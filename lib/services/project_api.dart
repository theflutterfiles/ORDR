import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';

class ProjectApi {
  AuthNotifier authNotifier = new AuthNotifier();

  getProjects(
    ProjectNotifier projectListNotifier, String uid
  ) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .getDocuments();

    List<Project> _projectList = [];

    snapshot.documents.forEach((document) {
      Project project = Project.fromMap(document.data);
      _projectList.add(project);
    });
    projectListNotifier.projectList = _projectList;
  }

  addProject(String uid, Project project) async {

    DocumentReference docRef = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .add(project.toJson());

    project.id = docRef.documentID;

    docRef.setData(project.toJson(), merge: true);

  }


}
