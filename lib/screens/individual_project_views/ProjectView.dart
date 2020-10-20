import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/menu_drawer_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
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
import 'package:provider/provider.dart';

class ProjectDetailView extends StatefulWidget {
  @override
  _ProjectDetailViewState createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _showBottomSheet(context) {
    scaffoldState.currentState.showBottomSheet((context) => AddTaskModal(

    ));
  }

  @override
  Widget build(BuildContext context) {
    ProjectNotifier _projectNotifier =
        Provider.of<ProjectNotifier>(context, listen: false);
    MenuDrawerNorifier drawerNorifier =
        Provider.of<MenuDrawerNorifier>(context, listen: false);
    drawerNorifier.setCurrentDrawer(1);

    int _getDaysUntilCompletion() {
      int diff = _projectNotifier.currentProject.endDate
          .difference(DateTime.now())
          .inDays;
      if (diff < 0) {
        diff = 0;
      }
      return diff;
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String budget = "\$" + _projectNotifier.currentProject.budget.toString();

    return Scaffold(
      key: scaffoldState,
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
      ),
      drawer: CollapsingNavigationDrawer("Dashboard"),
      drawerDragStartBehavior: DragStartBehavior.start,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: " " +
                                    _projectNotifier
                                        .currentProject.projectName +
                                    "\n",
                                style: GoogleFonts.poppins(
                                  textStyle: AppThemes.display1,
                                  color: AppThemeColours.Purple,
                                ),
                              ),
                              TextSpan(
                                  text: "  Started: " +
                                      DateFormat("dd MMM yyyy").format(
                                          _projectNotifier
                                              .currentProject.created),
                                  style: AppThemes.DateSubtitle),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 10, top: 20, bottom: 20),
                          child: ProgressBarCard(
                            completionPercentage: 50.0,
                            lineWidth: 10,
                            radius: 100,
                            text: "50%",
                            colour: AppThemeColours.OrangeColour,
                          ),
                        ),
                      ],
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
                            icon: DashboardIconThemes.OpenTaskIcon,
                            gradient: AppThemeColours.BlueGreenLinearGradient,
                            content: "5",
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.33,
                          height: screenHeight * 0.35,
                          child: CustomDashboardCard(
                            title: "Closed",
                            icon: DashboardIconThemes.TasksIcon,
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
                    documentReference: _projectNotifier.currentProject.id,
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
