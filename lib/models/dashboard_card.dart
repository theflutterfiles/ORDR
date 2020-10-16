import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';

class DashboardCard{

  String title;
  IconData icon;
  Action onNavigationSelection;
  Container content;
  Color colour;

  DashboardCard({this.title, this.icon, @required this.content, this.colour});

}
  List<DashboardCard> dashboardItems = [

    DashboardCard(icon: Icons.monetization_on_rounded, title: "Budget", content: new Container(), colour: AppThemeColours.DashboardCardColors[0]),
    DashboardCard(icon: Icons.check_circle, title: "Tasks", content: new Container()),
    DashboardCard(icon: Icons.check_circle_outline_rounded, title: "Completed", content: new Container()),
    DashboardCard(icon: Icons.lock_open, title: "In Progress", content: new Container()),
    DashboardCard(icon: Icons.lock, title: "Closed", content: new Container()),
    DashboardCard(icon: Icons.date_range, title: "Target Date", content: new Container()),
  ];