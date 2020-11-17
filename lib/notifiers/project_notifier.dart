import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';

class ProjectNotifier with ChangeNotifier {
  List<Project> _projectList = [];

  List<Collaborator> _collabsList = [];

  Project _currentProject;

  UnmodifiableListView<Project> get projectList =>
      UnmodifiableListView(_projectList);

  UnmodifiableListView<Collaborator> get collabsList =>
      UnmodifiableListView(_collabsList);

  Project get currentProject => _currentProject;

  set projectList(List<Project> projectList) {
    _projectList = projectList;
    notifyListeners();
  }

  set collabsList(List<Collaborator> collabsList) {
    _collabsList = collabsList;
    notifyListeners();
  }

  set currentProject(Project project) {
    _currentProject = project;
    notifyListeners();
  }

  void addProject(Project project) {
    _projectList.add(project);
    notifyListeners();
  }

  void removeProject(Project project) {
    _projectList.remove(project);
    notifyListeners();
  }
}
