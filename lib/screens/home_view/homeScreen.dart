import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/collapsing_navigation_drawer.dart';
import 'package:provider/provider.dart';
import '../../widgets/home_page/home_page_widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    AuthNotifier _authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Color(0xFF333333),
              size: 25.0,
            ),
            onPressed: () async {
              await signOut(_authNotifier);
            }),
        actions: <Widget>[
          AddIcon(),
          SearchIcon(),
        ],
      ),
      drawer: CollapsingNavigationDrawer("home"),
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
