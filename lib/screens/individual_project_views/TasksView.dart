import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/collapsing_navigation_drawer.dart';

class TasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu_rounded,
                size: 40,
                color: AppThemeColours.NavigationBarColor,
              ),
              color: Colors.black,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      drawer: CollapsingNavigationDrawer("Tasks"),
    );
  }
}