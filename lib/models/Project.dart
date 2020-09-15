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
   Timestamp created;
   Timestamp lastEdited;
   Timestamp projectedEndDate;

  //budget
   double budget;
   List<double> expenses;

  Project({this.tasks, this.collaborators, this.projectedEndDate, this.budget, this.expenses, this.goals, this.mission, this.colour,
      this.projectName, this.description, this.created, this.lastEdited});

  Project.fromMap(Map<String, dynamic> data){
    projectName = data['projectName'];
    description = data['description'];
    mission = data['mission'];
    goals = data['goals'];
    colour = data['colour'];

    tasks = data['tasks'];
    collaborators = data['collaborators'];

    created = data['created'];
    lastEdited = data['lastEdited'];
    tasks = data['tasks'];
    projectedEndDate = data['projectEndDate'];

    budget = data['budget'];
    expenses = data['expenses'];
  }

}