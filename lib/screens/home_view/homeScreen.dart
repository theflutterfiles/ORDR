import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/menu_drawer_notifier.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/menu/collapsing_navigation_drawer.dart';
import 'package:provider/provider.dart';
import 'widgets/home_page_widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    AuthNotifier _authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    MenuDrawerNorifier _menuDrawerNotifier =
        Provider.of<MenuDrawerNorifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
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
        actions: <Widget>[
          AddIcon(),
          SearchIcon(),
        ],
      ),
      drawer: CollapsingNavigationDrawer("Home"),
      drawerDragStartBehavior: DragStartBehavior.start,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppThemeColours.DashboardWhite,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeadingText(),
              Expanded(
                child: ProjectsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
