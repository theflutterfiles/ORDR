import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Checklist.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';

class TaskApi {
  AuthNotifier authNotifier = new AuthNotifier();

  getTasks(TaskNotifier taskNotifier, String uid, String projectId) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectId)
        .collection("tasks")
        .getDocuments();

    List<Task> _taskList = [];

    snapshot.documents.forEach((document) {
      Task task = Task.fromMap(document.data);

      _taskList.add(task);
    });
    taskNotifier.taskList = _taskList;
  }

  getChecklists(TaskNotifier taskNotifier, String uid, String projectId, String taskId) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectId)
        .collection("tasks")
        .document(taskId)
        .collection("checklists")
        .getDocuments();

    List<Checklist> _checklist = [];

    snapshot.documents.forEach((document) {
      Checklist checklist = Checklist.fromMap(document.data);

      _checklist.add(checklist);
    });
    taskNotifier.currentCheckList = _checklist;
  }



//   getChecklist(TaskNotifier taskNotifier, String uid, String projectId,
//       String taskId, int length) async {
//     DocumentReference docRef = Firestore.instance
//         .collection("users")
//         .document(uid)
//         .collection("projects")
//         .document(projectId)
//         .collection("tasks")
//         .document(taskId);

// DocumentSnapshot snapshot = await docRef.get();
        

//     if(snapshot.exists){
//       List<Checklist> _list = [];

//     if(snapshot['checkslist'] != null){
//       snapshot['checklist'].forEach((item) {
//       Checklist c =
//           new Checklist(title: item['title'], checked: item['checked']);
//           _list.add(c);
//     });

//     }else{
//       return null;
//     }
    
//     taskNotifier.checkList = _list;
        
//     }else{
//       return;
//     }
//   }

  addTask(String uid, String projectID, Task task,
      TaskNotifier taskNotifier) async {
    DocumentReference docRef = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectID)
        .collection("tasks")
        .add(task.toJson());

    task.id = docRef.documentID;
    docRef.setData(task.toJson(), merge: true);

    taskNotifier.addTask(task);
  }
  
  addChecklistItem(String uid, String projectID, Task task, Checklist checklist,
       String taskId, TaskNotifier taskNotifier) async {
       DocumentReference docRef = await Firestore.instance
         .collection("users")
         .document(uid)
         .collection("projects")
         .document(projectID)
         .collection("tasks")
         .document(taskId)
         .collection("checklists")
         .add(checklist.toJson());
      
      checklist.id = docRef.documentID;
      docRef.setData(checklist.toJson(), merge: true);

      taskNotifier.addChecklist(checklist);

       }
  // addChecklistItem(String uid, String projectID, Task task, Checklist checklist,
  //     String taskId, TaskNotifier taskNotifier) async {
  //   await Firestore.instance
  //       .collection("users")
  //       .document(uid)
  //       .collection("projects")
  //       .document(projectID)
  //       .collection("tasks")
  //       .document(taskId)
  //       .updateData({
  //     'checklist': FieldValue.arrayUnion([checklist.toJson()])
  //   });

  //   taskNotifier.addChecklist(checklist);
  // }

  checkListItem(String uid, String projectID, Task task,
      TaskNotifier taskNotifier, int index, String flag) async {
    DocumentReference docRef = Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectID)
        .collection("tasks")
        .document(task.id);

    print(docRef.documentID);

    docRef.updateData({
      "checklist": {"completed": flag}
    });
  }
}
