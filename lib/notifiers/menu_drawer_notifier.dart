import 'package:flutter/material.dart';

class MenuDrawerNorifier with ChangeNotifier{
  int _currentDrawer = 0;
  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int drawer){
    _currentDrawer = drawer;
    notifyListeners();
  }

  void increment(){
    notifyListeners();
  }
}