import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';

class TaskNotifier with ChangeNotifier {
  List<Task> _taskList = [];

  Project _currentProject;
  Task _currentTask;

  int _completedTasks = 0;
  int _openTasks = 0;

  UnmodifiableListView<Task> get taskList =>
      UnmodifiableListView(_taskList);

  Project get currentProject => _currentProject;

  Task get currentTask => _currentTask;

  int get completedTasks => _completedTasks;

  int get openTasks => _openTasks;

  set taskList(List<Task> taskList) {
    _taskList = taskList;
    notifyListeners();
  }

  set currentTask(Task task) {
    _currentTask = task;
    notifyListeners();
  }

  void incrementCompletedTasks(){
    _completedTasks++;
    notifyListeners();
  }

  void incrementOpenTasks(){
    _openTasks++;
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
