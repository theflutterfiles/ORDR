import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/dashboard_view/widgets/tasks_list.dart';
import 'package:flutter_app_mindful_lifting/screens/modals/add_task_modal.dart';
import 'package:flutter_app_mindful_lifting/styles/box_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/screens/tasks_view/widgets/tasks_list_horizontal.dart';
import 'package:flutter_app_mindful_lifting/screens/tasks_view/userCalendar.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/menu/collapsing_navigation_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class TasksView extends StatefulWidget {
  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  void _showAddTaskBottomSheet(context) {
    scaffoldState.currentState.showBottomSheet((context) => AddTaskModal());
  }

  @override
  Widget build(BuildContext context) {
    ProjectNotifier _projectNotifier =
        Provider.of<ProjectNotifier>(context, listen: false);

    // int _getDaysUntilCompletion() {
    //   int diff = _projectNotifier.currentProject.endDate
    //       .difference(DateTime.now())
    //       .inDays;
    //   if (diff < 0) {
    //     diff = 0;
    //   }
    //   return diff;
    // }

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String budget = "\$" + _projectNotifier.currentProject.budget.toString();
    bool checked = true;

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                _showAddTaskBottomSheet(context);
              },
              icon: Icon(
                Icons.add,
                color: Color(0xFF333333),
                size: 40.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                _showDialog();
              },
              icon: Icon(
                Icons.list,
                color: Color(0xFF333333),
                size: 40.0,
              ),
            ),
          ),
        ],
      ),
      drawer: CollapsingNavigationDrawer("Tasks"),
      drawerDragStartBehavior: DragStartBehavior.start,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppThemeColours.DashboardWhite,
          ),
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tasks",
                            style: GoogleFonts.poppins(
                              textStyle: AppThemes.display1,
                              //color: AppThemeColours.Purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 210,
                      height: 30,
                      margin: EdgeInsets.all(5),
                      decoration: nMbox.copyWith(
                          borderRadius: BorderRadius.circular(20)),
                      child: LinearPercentIndicator(
                        width: 200,
                        lineHeight: 20,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        // center: Text(
                        //   "50%",
                        //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        // ),
                        backgroundColor: AppThemeColours.LightPurple,
                        animateFromLastPercent: true,
                        progressColor: AppThemeColours.Purple,
                        percent: 50 / 100,
                        animation: true,
                      ),
                    ),
                  ],
                ),
              ),
              Calendar(),
              Expanded(child: TasksListHorizontal()),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            TasksList(),
          ],
        ),
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.grey,
      backgroundColor: Colors.white,
    );
  }
}
