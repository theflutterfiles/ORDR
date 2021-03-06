import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Checklist.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';

class TaskNotifier with ChangeNotifier {
  List<Task> _taskList = [];
  List<Task> _dailyTasks = [];

  List<Checklist> _checklist = [];

  Project _currentProject;
  Task _currentTask;

  int _completedTasks = 0;
  int _openTasks = 0;

  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);
  UnmodifiableListView<Checklist> get checklist =>
      UnmodifiableListView(_checklist);

  List<Task> get dailyTasks => _dailyTasks;

  Project get currentProject => _currentProject;

  Task get currentTask => _currentTask;

  int get completedTasks => _completedTasks;

  int get openTasks => _openTasks;

  set taskList(List<Task> taskList) {
    _taskList = taskList;
    notifyListeners();
  }

  set dailyTasks(List<Task> dailyTasks) {
    _dailyTasks = dailyTasks;
    notifyListeners();
  }

  set checklist(List<Checklist> checklist) {
    _checklist = checklist;
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
