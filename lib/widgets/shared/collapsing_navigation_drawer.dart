import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/account.dart';
import 'package:flutter_app_mindful_lifting/models/navigation_model.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/menu_drawer_notifier.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'collapsing_list.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  final String currentPage;

  CollapsingNavigationDrawer(this.currentPage);

  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    widthAnimation =
        Tween<double>(begin: 250, end: 0).animate(_animationController);
    MenuDrawerNorifier drawerNotifier =
        Provider.of<MenuDrawerNorifier>(context, listen: false);
    currentSelectedIndex = drawerNotifier.getCurrentDrawer;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(BuildContext context, Widget widget) {
    var currentDrawer = Provider.of<MenuDrawerNorifier>(context, listen: false);
    return Container(
      width: widthAnimation.value,
      decoration: new BoxDecoration(
        color: AppThemeColours.NavigationBarColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFc4c4c4),
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(1.0, 1.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: AccountTile(),
          ),
          Divider(
            height: 10,
            color: AppThemeColours.NavigationBarIconColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0, bottom: 20.0),
                    child: CollapsingListTitle(
                      onTap: () {
                        switch (index) {
                          case 0:
                            currentDrawer.setCurrentDrawer(0);
                            Navigator.popAndPushNamed(context, "home");
                            break;
                          case 1:
                            currentDrawer.setCurrentDrawer(1);
                            Navigator.popAndPushNamed(context, "dashboard");
                            break;
                          case 4:
                            currentDrawer.setCurrentDrawer(4);
                            Navigator.popAndPushNamed(context, "collaborators");
                            break;
                          case 5:
                            currentDrawer.setCurrentDrawer(5);
                            Navigator.popAndPushNamed(context, "tasks");
                            break;
                        }
                      },
                      isSelected: currentSelectedIndex == index,
                      icon: navigationItems[index].icon,
                      title: navigationItems[index].title,
                      textStyle: TextStyle(
                        fontSize: 20,
                      ),
                      animationController: _animationController,
                    ),
                  );
                },
                itemCount: navigationItems.length,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 108.0, left: 20.0),
            child: CollapsingListTitle(
              isSelected: false,
              icon: Icons.settings,
              title: 'Settings',
              animationController: _animationController,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget AccountTile() {
    final AuthNotifier _authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Column(
      children: [
        AvatarListTitle(
          displayName: _authNotifier.user.displayName,
          animationController: _animationController,
        ),
      ],
    );
  }
}
