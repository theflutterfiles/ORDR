import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';

class ProjectApi {
  AuthNotifier authNotifier = new AuthNotifier();

  getProjects(ProjectNotifier projectListNotifier, String uid) async {
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

  updateOpenTasks(String projectId, String uid, ProjectNotifier projectNotifier,
      Project project) async {
    int currentNum = projectNotifier.currentProject.openTasks;
    int updatedNum = currentNum + 1;

    DocumentReference docRef = Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectId);

    docRef.updateData({"openTasks": updatedNum}).whenComplete(
        () => projectNotifier.currentProject.openTasks = updatedNum)
        .then((value) => print(projectNotifier.currentProject.openTasks));

    projectNotifier.currentProject = project;
    
  }

  addProject(
      String uid, Project project, ProjectNotifier projectNotifier) async {
    DocumentReference docRef = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .add(project.toJson());

    project.id = docRef.documentID;

    docRef.setData(project.toJson(), merge: true);

    projectNotifier.addProject(project);
  }
}
