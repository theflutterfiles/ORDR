import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';
import 'package:flutter/material.dart';

class Project {
  //info
  String projectName;
  String description;
  String mission;
  List<String> goals;
  Color colour;

  //tasks
  List<Task> tasks;
  List<Collaborator> collaborators;

  //dates
  DateTime created;
  DateTime lastEdited;
  DateTime startDate;
  DateTime endDate;

  //budget
  double budget;
  List<double> expenses;

  Project(
      this.tasks,
      this.collaborators,
      this.startDate,
      this.endDate,
      this.budget,
      this.expenses,
      this.goals,
      this.mission,
      this.colour,
      this.projectName,
      this.description,
      this.created,
      this.lastEdited);

  Project.fromMap(Map<String, dynamic> data) {
    projectName = data['projectName'];
    description = data['description'];
    mission = data['mission'];
    goals = data['goals'];
    colour = data['colour'];

    tasks = data['tasks'];
    collaborators = data['collaborators'];

    created = data['created'];
    lastEdited = data['lastEdited'];
    startDate = data['startDate'];
    endDate = data['endDate'];

    budget = data['budget'];
    expenses = data['expenses'];
  }

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
        'projectName': projectName,
        'mission': mission,
        'description': description,
        'goals': [],
        'colour': colour,
        'collaborators': [],
        'created': created,
        'startDate': startDate,
        'endDate': endDate,
        'lastEdited': lastEdited,
        'budget': budget,
        'expenses': [],
        //'tasks' : [],
      };

// creating a Trip object from a firebase snapshot
  Project.fromSnapshot(DocumentSnapshot snapshot)
      : projectName = snapshot['projectName'],
        description = snapshot['description'],
        mission = snapshot['mission'],
        goals = null,
        colour = snapshot['colour'],
        tasks = null,
        collaborators = null,
        created = snapshot['created'].toDate(),
        //lastEdited = snapshot['lastEdited'].toDate(),
        //startDate = snapshot['startDate'].toDate(),
        endDate = snapshot['endDate'].toDate(),
        budget = snapshot['budget'],
        expenses = null;
}
