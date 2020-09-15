import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  //info
  String description;
  String status;
  String priority;
  Timestamp created;
  Timestamp lastEdited;
  Timestamp dueDate;

  //checklist
  List<String> checklist;

  //attachment
  List<String> attachments;

  Firestore _firestore = Firestore.instance;

  Task(
    this.status,
    this.priority,
    this.dueDate,
    this.checklist,
    this.attachments, {
    this.description,
    this.created,
    this.lastEdited,
  });

  Task.fromMap(Map<String, dynamic> data) {
    description = data['description'];
    status = data['status'];
    priority = data['priority'];
    description = data['description'];

    created = data['created'];
    lastEdited = data['lastEdited'];
    dueDate = data['dueDate'];

    checklist = data['checklist'];

    attachments = data['attachments'];
  }
}
