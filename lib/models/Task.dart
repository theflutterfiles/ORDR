import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  //info
  String title;
  String description;
  String status;
  String priority;
  DateTime created;
  DateTime lastEdited;
  DateTime dueDate;

  List<double> expenses;

  //checklist
  List<String> checklist;

  //attachment
  List<String> attachments;

  Task({
    this.status,
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

  factory Task.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data;
    return Task(
      title: data['title'] ?? "",
      description: data['description'] ?? "",
      status: data['status'] ?? "",
      priority: data['priority'] ?? "",

      created: data['created'].toDate(),
      //lastEdited = data['lastEdited'].toDate();
      dueDate: data['dueDate'].toDate() ?? null,

      checklist: data['checklist'] ?? null,

      attachments: data['attachments'] ?? null,

      expenses: data['expenses'] ?? null,
    );
  }

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'] ?? "",
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
        'title': title,
        'description': description,
        'status': status,
        'piority': priority,
        'created': created,
        'lastEdited': lastEdited,
        'dueDate': dueDate,
        'expenses': expenses,
        'checklist': checklist,
        'attachments': attachments,
      };
}
