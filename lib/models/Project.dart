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

  Project(this.tasks, this.collaborators, this.startDate, this.endDate, this.budget, this.expenses, this.goals, this.mission, this.colour,
      this.projectName, this.description, this.created, this.lastEdited);

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
    startDate = data['startDate'];
    endDate = data['projectEndDate'];

    budget = data['budget'];
    expenses = data['expenses'];
  }

  String convertToString(){
    return "name: " + this.projectName + "\n"
        + "mission: " + this.mission + "\n"
        + "created: " + this.created.toString() + "\n"
        + "start: " + this.startDate.toString() + "\n"
        + "last edited: " + this.lastEdited.toString() + "\n"
        + "budget: " + this.budget.toString();
  }

  Map<String, dynamic> toJson() => {

    'projectName' : projectName,
    'mision' : mission,
    'description' : description,
    'goals' : {

    },
    'colour' : colour,
    'tasks' : {

    },
    'collaborators' : {

    },
    'created' : created,
    'startDate' : startDate,
    'endDate' : endDate,
    'lastEdited' : lastEdited,

    'budget' : budget,
    'expenses' : {

    },
  };



}