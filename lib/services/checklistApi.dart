import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_mindful_lifting/models/Checklist.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/checklist_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';

class ChecklistApi {
  AuthNotifier authNotifier = new AuthNotifier();

  getChecklists(ChecklistNotifier checklistNotifier, TaskNotifier taskNotifier,
      String uid, String projectId, String taskId) async {
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
    checklistNotifier.checklist = _checklist;
  }

  // addChecklistItem(
  //     String uid,
  //     String projectID,
  //     Task task,
  //     Checklist checklist,
  //     String taskId,
  //     TaskNotifier taskNotifier,
  //     ChecklistNotifier checklistNotifier) async {
  //   DocumentReference docRef = await Firestore.instance
  //       .collection("users")
  //       .document(uid)
  //       .collection("projects")
  //       .document(projectID)
  //       .collection("tasks")
  //       .document(taskId)
  //       .collection("checklists")
  //       .add(checklist.toJson());

  //   checklist.id = docRef.documentID;
  //   docRef.setData(checklist.toJson(), merge: true);

  //   checklistNotifier.addChecklist(checklist);
  // }
}
