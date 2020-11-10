import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Checklist.dart';

class ChecklistNotifier extends ChangeNotifier {

  List<Checklist> _checklist = [];

  Checklist _currentChecklist;

  int _completed;
  int _open;

  UnmodifiableListView<Checklist> get checklist =>
      UnmodifiableListView(_checklist);

  Checklist get currentChecklist => _currentChecklist;

  int get completed => _completed;

  int get open => _open;

  set checklist(List<Checklist> checklist) {
    _checklist = checklist;
    notifyListeners();
  }

  set currentChecklist(Checklist currentChecklist) {
    currentChecklist = _currentChecklist;
  }

  void addChecklist(Checklist checklist) {
    _checklist.add(checklist);
    notifyListeners();
  }

  void removeChecklist(Checklist checklist) {
    _checklist.remove(checklist);
    notifyListeners();
  }
}
