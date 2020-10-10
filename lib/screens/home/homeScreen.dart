import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        leading: MenuIcon(
        ),
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
