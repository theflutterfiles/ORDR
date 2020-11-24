import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';

class ProjectApi {
  AuthNotifier authNotifier = new AuthNotifier();

  getProjects(ProjectNotifier projectListNotifier, String uid) async {
    List<Project> _projectList = [];

    QuerySnapshot snapshot = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .getDocuments();

    snapshot.documents.forEach((document) {
      List<Collaborator> _collabsList = [];
      Project project = Project.fromMap(document.data);
      document.data['collaborators'].forEach((item) {
        Collaborator collaborator = new Collaborator(
            name: item['name'],
            email: item['email'],
            number: item['number'],
            instagram: item['instagram']);
        _collabsList.add(collaborator);
        _collabsList.sort((a, b) => a.name.compareTo(b.name));
        project.collaborators = _collabsList;
        projectListNotifier.collabsList = _collabsList;
      });
      _projectList.add(project);
    });
    projectListNotifier.projectList = _projectList;
    
  }

// getProjectByID(ProjectNotifier projectListNotifier, String uid) async {
//     List<Project> _projectList = [];

//     DocumentSnapshot snapshot = await Firestore.instance
//         .collection("users")
//         .document(uid)
//         .collection("projects")
//         .document(projectListNotifier.currentProject.id)
//         .get();

//     snapshot.data.forEach((document) {
//       List<Collaborator> _collabsList = [];
//       Project project = Project.fromMap(document.data);
//       document.data['collaborators'].forEach((item) {
//         Collaborator collaborator = new Collaborator(
//             name: item['name'],
//             email: item['email'],
//             number: item['number'],
//             instagram: item['instagram']);
//         _collabsList.add(collaborator);
//         project.collaborators = _collabsList;
//         projectListNotifier.collabsList = _collabsList;
//       });
//       _projectList.add(project);
//     });
//     projectListNotifier.projectList = _projectList;
    
//   }

  updateOpenTasks(String projectId, String uid, ProjectNotifier projectNotifier,
      Project project) async {
    int currentNum = projectNotifier.currentProject.openTasks;
    int updatedNum = currentNum + 1;

    DocumentReference docRef = Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectId);

    docRef
        .updateData({"openTasks": updatedNum})
        .whenComplete(
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

  addCollaborator(String uid, String projectID, Collaborator collaborator,
      ProjectNotifier projectNotifier) async {

      
    await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectID)
        .updateData({
      'collaborators': FieldValue.arrayUnion([collaborator.toJson()])
    });

    List<Collaborator> _collabList2 = projectNotifier.currentProject.collaborators;
    _collabList2.add(collaborator);
    _collabList2.sort((a, b) => a.name.compareTo(b.name));
    projectNotifier.collabsList = _collabList2;
    projectNotifier.currentProject.collaborators = _collabList2;
  }
}
