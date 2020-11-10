import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/checklist_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/menu_drawer_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/authenticate/login.dart';
import 'package:flutter_app_mindful_lifting/screens/individual_project_views/ProjectView.dart';
import 'package:flutter_app_mindful_lifting/screens/individual_project_views/TasksView.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'notifiers/project_notifier.dart';
import 'screens/home_view/homeScreen.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProjectNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider<MenuDrawerNorifier>(
          create: (_) => MenuDrawerNorifier(),
        ),
        ChangeNotifierProvider<TaskNotifier>(
          create: (_) => TaskNotifier()),
        ChangeNotifierProvider<ChecklistNotifier>(
            create: (_) => ChecklistNotifier()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //wrap wrapper in provider
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
      //the widgets inside here can access the values provided by stream provider value above e.g. user data from Stream<User> get user
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? HomePage() : Login();
        },
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: {
        "home": (_) => HomePage(),
        "tasks": (_) => TasksView(),
        "login": (_) => Login(),
        "dashboard": (_) => ProjectDetailView(),
      },
      supportedLocales: [
        const Locale('en', ''),
        //const Locale('aus', ''),
      ],
    );
  }
}
