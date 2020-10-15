import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';

class ProjectNotifier with ChangeNotifier {
  List<Project> _projectList = [];

  UnmodifiableListView<Project> get projectList =>
      UnmodifiableListView(_projectList);

  void addProject(Project project) {
    _projectList.add(project);
    notifyListeners();
  }
}
