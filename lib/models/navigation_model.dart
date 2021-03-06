import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  Action onNavigationSelection;

  NavigationModel({@required this.title, @required this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(icon: Icons.home_rounded, title: "Home"),
  NavigationModel(icon: Icons.dashboard_rounded, title: "Dashboard"),
  NavigationModel(icon: Icons.info_rounded, title: "About"),
  NavigationModel(icon: Icons.monetization_on_rounded, title: "Expenses"),
  NavigationModel(icon: Icons.person_pin, title: "Collab"),
  NavigationModel(icon: Icons.check_circle, title: "Tasks"),
  NavigationModel(icon: Icons.date_range_rounded, title: "Events"),
];
