import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_mindful_lifting/models/Checklist.dart';

class Task {
  //info
  String projectId;
  String id;
  String title;
  String description;
  bool status;
  String priority;
  DateTime created;
  DateTime lastEdited;
  DateTime dueDate;

  List expenses = [];

  //checklist
  List checklist = [];

  //attachment
  List attachments = [];

  Task({
    this.status,
    this.id,
    this.projectId,
    this.priority,
    this.dueDate,
    this.checklist,
    this.attachments,
    this.description,
    this.title,
    this.created,
    this.lastEdited,
    this.expenses,
  });

  Task.fromMap(Map<String, dynamic> data) {
    projectId = data['projectId'];
    id = data['id'];
    title = data['title'];
    description = data['description'] ?? null;
    status = data['status'] ?? null;
    priority = data['priority'] ?? null;
    created = data['created'].toDate();
    lastEdited = data['lastEdited'].toDate() ?? null;
    dueDate = data['dueDate'].toDate() ?? null;
    expenses = data['expenses'] ?? null;
    checklist = data['checklist'] ?? null;
    attachments = data['attachments'] ?? null;
  }

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'] ?? "",
      id = snapshot['id'],
        description = snapshot['description'] ?? "",
        status = snapshot['status'] ?? "",
        priority = snapshot['priority'] ?? "",
        created = snapshot['created'].toDate(),
        lastEdited = snapshot['lastEdited'].toDate(),
        dueDate = snapshot['dueDate'].toDate() ?? null,
        checklist = snapshot['checklist'] ?? null,
        attachments = snapshot['attachments'] ?? null,
        expenses = snapshot['expenses'] ?? null;

  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'id' : id,
        'title': title,
        'description': description,
        'status': status,
        'priority': priority,
        'created': created,
        'lastEdited': lastEdited,
        'dueDate': dueDate,
        'expenses': expenses,
        'checklist': checklist,
        'attachments': attachments,
        
      };
  
}
