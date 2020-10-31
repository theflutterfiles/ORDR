import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/task_api.dart';
import 'package:flutter_app_mindful_lifting/styles/box_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/tasks_page/slimy_task_list.dart';
import 'package:flutter_app_mindful_lifting/widgets/tasks_page/task_card.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/project_progress_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

class TasksListHorizontal extends StatefulWidget {
  @override
  _TasksListHorizontalState createState() => _TasksListHorizontalState();
}

class _TasksListHorizontalState extends State<TasksListHorizontal> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TaskApi taskApi = new TaskApi();

    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);

    return Column(children: <Widget>[
      Container(
        //padding: EdgeInsets.all(20),
        height: 0.55 * screenHeight,
        width: 0.9 * screenWidth,
        //decoration: AppThemeColours.BlueGreenGradientBox,
        child: Consumer<TaskNotifier>(
          builder: (BuildContext context, value, Widget child) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: taskNotifier.taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: SlimyCard(
                      bottomCardHeight: 245,
                      color: Colors.white,
                      width: screenWidth * 0.9,
                      topCardHeight: 180,
                      topCardWidget: TaskCard(
                        index: index,
                      ),
                      bottomCardWidget: Column(
                        children: [
                          Container(
                            child: Icon(Icons.add),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  taskNotifier.taskList[index].checklist.length,
                              itemBuilder: (BuildContext context, int i) {
                                List checkList = taskNotifier
                                    .taskList[index].checklist
                                    .toList();

                                String completed =
                                    checkList[i]['completed'].toString();
                                var checked = completed.toLowerCase() == "true";
                                ProjectNotifier projectNotifier =
                                    Provider.of<ProjectNotifier>(context,
                                        listen: false);
                                String currentUserUID =
                                    Provider.of<AuthNotifier>(context,
                                            listen: false)
                                        .user
                                        .uid;
                                return CheckboxListTile(
                                  title: Text(checkList[i]['title'].toString()),
                                  value: checked,
                                  onChanged: (bool value) {
                                    setState(() {
                                      checked = value;
                                      if (value == true) {
                                        taskApi.checkListItem(
                                            currentUserUID,
                                            projectNotifier.currentProject.id,
                                            taskNotifier.taskList[index],
                                            taskNotifier,
                                            index,
                                            checked.toString());
                                      } else {
                                        taskApi.checkListItem(
                                            currentUserUID,
                                            projectNotifier.currentProject.id,
                                            taskNotifier.taskList[index],
                                            taskNotifier,
                                            index,
                                            checked.toString());
                                      }
                                    });
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                    onTap: () {
                      taskNotifier.currentTask = taskNotifier.taskList[index];
                    },
                  );
                });
          },
        ),
      ),
    ]);
  }
}
