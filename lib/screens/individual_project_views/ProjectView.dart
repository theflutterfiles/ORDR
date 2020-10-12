import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';
import 'package:flutter_app_mindful_lifting/screens/add_task_views/add_task_modal.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/dashboard/dashboard_icons.dart';
import 'package:flutter_app_mindful_lifting/widgets/dashboard/tasks_list.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/collapsing_navigation_drawer.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/dashboard_add_task_card.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/dashboard_card.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/project_progress_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProjectDetailView extends StatefulWidget {
  final Project project;
  final String documentReference;

  ProjectDetailView(
      {Key key, @required this.project, @required this.documentReference})
      : super(key: key);

  @override
  _ProjectDetailViewState createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
  Task task;
  final scaffoldState = GlobalKey<ScaffoldState>();

  void _showBottomSheet(context) {
    Task task = new Task(null, null, null, null, null);

    print(widget.documentReference);

    scaffoldState.currentState.showBottomSheet((context) => AddTaskModal(
          projectName: widget.project.projectName,
          task: task,
          documentReference: widget.documentReference,
        ));
  }

  @override
  Widget build(BuildContext context) {
    int _getDaysUntilCompletion() {
      int diff = widget.project.endDate.difference(DateTime.now()).inDays;
      if (diff < 0) {
        diff = 0;
      }
      return diff;
    }

    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String budget = "\$" + widget.project.budget.toString();

    return Scaffold(
      key: scaffoldState,
      backgroundColor: Color(0xFFEbEBEB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEbEBEB),
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
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: " " + widget.project.projectName + "\n",
                                  style: GoogleFonts.poppins(
                                    textStyle: AppThemes.display1,
                                  ),
                                ),
                                TextSpan(
                                    text: "  Started: " +
                                        DateFormat("dd MMM yyyy")
                                            .format(widget.project.created),
                                    style: AppThemes.DateSubtitle),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                            
                            child: ProgressBarCard(
                              completionPercentage: 50.0,
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.18,
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.35,
                          height: screenHeight * 0.35,
                          child: CustomDashboardCard(
                            title: "Due in",
                            icon: DashboardIconThemes.TargetCompletionIcon,
                            gradient: AppThemeColours.BlueGreenLinearGradient,
                            content: _getDaysUntilCompletion().toString(),
                          ),
                        ),
                        Container(
                          width: 229,
                          child: CustomDashboardCard(
                            title: "Budget",
                            icon: DashboardIconThemes.BudgetIcon,
                            gradient: AppThemeColours.BlueGreenLinearGradient,
                            content: budget,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 10),
                          child: Text(
                            "Tasks",
                            style: AppThemes.DashboardCardTitleText.copyWith(
                                fontSize: 30),
                          ),
                        ),
                      ),
                      //Container(child: DashboardIconThemes.AddTaskIcon, padding: EdgeInsets.only(top: 15),),
                    ],
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.18,
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.33,
                          height: screenHeight * 0.35,
                          child: CustomDashboardCard(
                            title: "Open",
                            icon: DashboardIconThemes.TargetCompletionIcon,
                            gradient: AppThemeColours.BlueGreenLinearGradient,
                            content: "5",
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.33,
                          height: screenHeight * 0.35,
                          child: CustomDashboardCard(
                            title: "Closed",
                            icon: DashboardIconThemes.BudgetIcon,
                            gradient: AppThemeColours.BlueGreenLinearGradient,
                            content: "10",
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.35,
                            child: CustomDashboardAddTaskCard2(
                              icon: DashboardIconThemes.AddTaskIcon,
                              title: "Add Task",
                              content: "",
                              gradient: AppThemeColours.BlueGreenLinearGradient,
                            ),
                          ),
                          onTap: () {
                            _showBottomSheet(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: TasksList(
                    documentReference: widget.documentReference,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
