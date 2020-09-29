import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/screens/account.dart';
import 'package:flutter_app_mindful_lifting/screens/addProject.dart';
import 'package:flutter_app_mindful_lifting/screens/authenticate/authenticate.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/shared/loading.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../userCalendar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../widgets/home_page/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);



    return Scaffold(
      backgroundColor: Color(0xFFEbEBEB),
      appBar: AppBar(
        leading: MenuIcon(),
        actions: <Widget>[
          AddIcon(),
          SearchIcon(),
        ],
      ),
      body: SafeArea(
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
    );
  }
}
