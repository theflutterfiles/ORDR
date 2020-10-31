import 'package:cloud_firestore/cloud_firestore.dart';
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

  getChecklist(TaskNotifier taskNotifier, String uid, String projectId,
      String taskId) async {
    DocumentReference docRef = await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectId)
        .collection("tasks")
        .document(taskId);



    //List<Map<String, Object>> checklist = (List<Map<String, Object>>) docRef.get("users");

    // snapshot.forEach((document) {
    //   Task task = Task.fromMap(document.data);

    //   _taskList.add(task);
    // });
    // taskNotifier.taskList = _taskList;
  }

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
    await Firestore.instance
        .collection("users")
        .document(uid)
        .collection("projects")
        .document(projectID)
        .collection("tasks")
        .document(taskId)
        .updateData({
      'checklist': {checklist.toJson()}
    });

    taskNotifier.addChecklist(checklist);
  }

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
