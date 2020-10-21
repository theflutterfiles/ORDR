import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';

class TaskNotifier with ChangeNotifier {
  List<Task> _taskList = [];

  Project _currentProject;
  Task _currentTask;

  UnmodifiableListView<Task> get taskList =>
      UnmodifiableListView(_taskList);

  Project get currentProject => _currentProject;

  Task get currentTask => _currentTask;

  set taskList(List<Task> taskList) {
    _taskList = taskList;
    notifyListeners();
  }

  set currentTask(Task task) {
    _currentTask = task;
    notifyListeners();
  }

  void addTask(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _taskList.remove(task);
    notifyListeners();
  }
}
