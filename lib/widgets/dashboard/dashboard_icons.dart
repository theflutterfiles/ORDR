import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';

class DashboardIconThemes{

 static const double iconSize = 40;

  static const Icon BudgetIcon = Icon(Icons.monetization_on_rounded, size: iconSize, color: AppThemeColours.NavigationBarColor);
  static const Icon TargetCompletionIcon = Icon(Icons.date_range_rounded, size: iconSize, color: AppThemeColours.NavigationBarColor);
  static const Icon TasksIcon = Icon(Icons.check_circle_rounded, size: iconSize, color: AppThemeColours.NavigationBarColor);
  static const Icon OpenTaskIcon = Icon(Icons.lock_open, size: iconSize, color: AppThemeColours.NavigationBarColor);
}