import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/models/dashboard_card.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/dashboard/dashboard_icons.dart';
import 'package:flutter_app_mindful_lifting/widgets/home_page/home_page_widgets.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/collapsing_navigation_drawer.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/dashboard_card.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/dashboard_task_card.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/project_progress_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_mindful_lifting/models/dashboard_card.dart';

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
    //final _scaffoldKey = new GlobalKey<ScaffoldState>();

    String budget = "\$" + project.budget.toString();

    return Scaffold(
      backgroundColor: AppThemeColours.DashboardWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //key: _scaffoldKey,
        backgroundColor: AppThemeColours.DashboardWhite,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded, size: 40, color: AppThemeColours.NavigationBarColor,),
              color: Colors.black,
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
      drawer: CollapsingNavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppThemeColours.DashboardWhite,
              ),
              padding: EdgeInsets.all(20),
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: " " + project.projectName + "\n",
                              style: GoogleFonts.poppins(
                                textStyle: AppThemes.display1,
                              ),
                            ),
                            
                            TextSpan(text: "  Started: " + DateFormat("dd MMM yyyy").format(project.created), style: AppThemes.DateSubtitle),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  
                  //SizedBox(height: 50,),
                  Expanded(
                    child: Row(
                      children: [
                        CustomDashboardCard(
                          title: "Budget",
                          icon: DashboardIconThemes.BudgetIcon,
                          gradient: AppThemeColours.dashboardCardGradient,
                          content: budget,
                        ),
                        CustomDashboardCard(
                          title: "Due in",
                          icon: DashboardIconThemes.TargetCompletionIcon,
                          gradient: AppThemeColours.dashboardCardGradient,
                          content: _getDaysUntilCompletion().toString(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4, top: 20),
                    height: 80,
                    child: ProgressBarCard(
                      title: " Task Progress",
                      completionPercentage: 50.0,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CustomDashboardCard(
                          title: "Open Tasks",
                          icon: DashboardIconThemes.OpenTaskIcon,
                          gradient: AppThemeColours.dashboardCardGradient,
                          content: "5",
                        ),
                        CustomDashboardCard(
                          title: "Closed Tasks",
                          icon: DashboardIconThemes.TasksIcon,
                          gradient: AppThemeColours.dashboardCardGradient,
                          content: "10",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      CustomDashboardCard(
                        title: "Tasks",
                        icon: DashboardIconThemes.TasksIcon,
                        gradient: AppThemeColours.dashboardCardGradient,
                        content: "",
                      ),
                    ],
                  )),
                  Expanded(
                      child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.20,
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String cardTitle;
  final Icon cardIcon;
  final String cardData;

  const CustomCard(
      {Key key, @required this.cardTitle, this.cardIcon, this.cardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        15.0,
      ),
      decoration: AppThemeColours.DashboardCardBox,
      child: Column(
        children: [
          Row(
            children: [
              Align(
                child: IconButton(
                  icon: cardIcon,
                  onPressed: null,
                  iconSize: 40,
                  color: Color(0xFF333333),
                ),
                alignment: Alignment.centerLeft,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  cardTitle,
                  style: TextStyle(fontSize: 20, color: Color(0xFF333333)),
                ),
              ),
            ],
          ),
          Text(cardData),
        ],
      ),
    );
  }
}
