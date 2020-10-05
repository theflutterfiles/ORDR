import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/home_page/home_page_widgets.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/collapsing_navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProjectDetailView extends StatelessWidget {

  Project project;

  ProjectDetailView({Key key, @required this.project}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    int _getDaysUntilCompletion() {
    int diff = project.endDate.difference(DateTime.now()).inDays;
    if (diff < 0) {
      diff = 0;
    }
    return diff;
  }

  
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //backgroundColor: Color(0xFFC4C4C4),
      //appBar: AppBar(title: Text(""), backgroundColor: Color(0xFF333333),),
      body: Stack(children: [
        Container(
          
          width: screenWidth * 0.80,
          
          //color: Color(0xFF333333),
        ),
        CollapsingNavigationDrawer(),
        

      ],
      ),

);
  }
}


class CustomCard extends StatelessWidget {

  final String cardTitle;
  final Icon cardIcon;
  final String cardData;


const CustomCard({Key key, @required this.cardTitle, this.cardIcon, this.cardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(15.0,),
    decoration: AppThemeColours.DashboardCardBox,
    child: Column(children: [
      Row(children: [
        Align(child: IconButton(icon: cardIcon, onPressed: null, iconSize: 40, color: Color(0xFF333333),), alignment: Alignment.centerLeft,),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(cardTitle, style: TextStyle(fontSize: 20, color: Color(0xFF333333)),),
        ),
      ],),
    
      Text(cardData),
    ],),
    );
  }
}



