import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';

class TaskApi {
  AuthNotifier authNotifier = new AuthNotifier();

  getTasks(
    TaskNotifier taskNotifier, String uid, String projectId
  ) async {
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
      // if(task.status == true){
      //   taskNotifier.incrementCompletedTasks();
      // }else if(task.status == false){
      //   taskNotifier.incrementOpenTasks();
      // }
      _taskList.add(task);
    });
    taskNotifier.taskList = _taskList;
  }

  addTask(String uid, String projectID, Task task) async {

     await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectID)
        .collection("tasks")
        .add(task.toJson());

  }
}
