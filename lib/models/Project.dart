import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Project with ChangeNotifier {
  //info
  String id;
  String projectName;
  String description;
  String mission;
  List goals = [];
  String colour;
  int openTasks;
  int completedTasks;

  //tasks
  List tasks = [];
  List collaborators = [];

  //dates
  DateTime created;
  DateTime lastEdited;
  DateTime startDate;
  DateTime endDate;

  //budget
  double budget;
  List expenses = [];

  Project(
      {this.tasks,
      this.id,
      this.collaborators,
      this.startDate,
      this.endDate,
      this.budget,
      this.openTasks = 0,
      this.completedTasks = 0,
      this.expenses,
      this.goals,
      this.mission,
      this.colour,
      this.projectName,
      this.description,
      this.created,
      this.lastEdited});

  String convertToString() {
    return "name: " +
        this.projectName +
        "\n" +
        "mission: " +
        this.mission +
        "\n" +
        "created: " +
        this.created.toString() +
        "\n" +
        "start: " +
        this.startDate.toString() +
        "\n" +
        "last edited: " +
        this.lastEdited.toString() +
        "\n" +
        "budget: " +
        this.budget.toString();
  }

  Map<String, dynamic> toJson() => {
        'id' : id,
        'projectName': projectName,
        'mission': mission,
        'description': description,
        'goals': [],
        'openTasks' : openTasks,
        'completedTasks' : completedTasks,
        'colour': colour,
        'collaborators': collaborators,
        'created': created,
        'startDate': startDate,
        'endDate': endDate,
        'lastEdited': lastEdited,
        'budget': budget,
        'expenses': [],
        
      };

// creating a Trip object from a firebase snapshot
  Project.fromSnapshot(DocumentSnapshot snapshot)
      : projectName = snapshot['projectName'],
        description = snapshot['description'],
        mission = snapshot['mission'],
        openTasks = snapshot['openTasks'],
        completedTasks = snapshot['completedTasks'],
        //goals = null,
        colour = snapshot['colour'],
        
        collaborators = snapshot['collaborators'] ?? null,
        created = snapshot['created'].toDate(),
        //lastEdited = snapshot['lastEdited'].toDate(),
        //startDate = snapshot['startDate'].toDate(),
        endDate = snapshot['endDate'].toDate(),
        budget = snapshot['budget'],
        expenses = null;

  Project.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    projectName = data['projectName'];
    description = data['description'] ?? null;
    mission = data['mission'];
    goals = data['goals'] ?? null;
    openTasks = data['openTasks'] ?? 0;
    completedTasks = data['completedTasks'] ?? 0;
    colour = data['colour'] ?? null;
    collaborators = data['collaborators'] ?? null;
    created = data['created'].toDate();
    lastEdited = data['lastEdited'].toDate();
    startDate = data['startDate'].toDate();
    endDate = data['endDate'].toDate();
    budget = data['budget'] ?? null;
    expenses = data['expenses'] ?? null;
  }
}
