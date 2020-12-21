import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/notifiers/menu_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/individual_project_views/ProjectView.dart';
import 'package:flutter_app_mindful_lifting/screens/individual_project_views/TasksView.dart';
import 'package:provider/provider.dart';
import 'screens/individual_project_views/homeScreen.dart';

void main() => runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => MenuDrawerNotifier())
      ],
      child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.transparent,
          focusColor: Color(0xFF333333),
        ),
        home: HomePage(),
        routes: {
          "home": (_) => HomePage(),
          "tasks": (_) => TasksView(),
          "projects": (_) => ProjectsView(),
        });
  }
}
