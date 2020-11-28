import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_mindful_lifting/models/Checklist.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/task_api.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/screens/tasks_view/widgets/task_card.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:slimy_card/slimy_card.dart';

class TasksListHorizontal extends StatefulWidget {
  @override
  _TasksListHorizontalState createState() => _TasksListHorizontalState();
}

TextEditingController textEditingController = new TextEditingController();

class _TasksListHorizontalState extends State<TasksListHorizontal> {
  @override
  void initState() {
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    String uid = Provider.of<AuthNotifier>(context, listen: false).user.uid;
    TaskApi taskApi = new TaskApi();
    String projectId =
        Provider.of<ProjectNotifier>(context, listen: false).currentProject.id;
    taskApi.getTasks(taskNotifier, uid, projectId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index % 2 == 0) {
          return _buildCarousel(context, index ~/ 2);
        } else {
          return Divider();
        }
      },
      itemCount: 1,
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: MediaQuery.of(context).size.height,

          child: PageView.builder(
            pageSnapping: true,
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.9),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(
                  context, carouselIndex, itemIndex, taskNotifier);
            },
            itemCount: taskNotifier.dailyTasks.length,
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int carouselIndex,
      int itemIndex, TaskNotifier taskNotifier) {
    var screenWidth = MediaQuery.of(context).size.width;

    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: true);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: SlimyCard(
        bottomCardHeight: 245,
        color: Colors.white,
        width: 380,
        topCardHeight: 180,
        topCardWidget: InkWell(
          child: TaskCard(
            index: itemIndex,
          ),
        ),
        bottomCardWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Checklist",
                    style: AppThemes.display2.copyWith(fontSize: 25),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _showDialog(itemIndex),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Consumer<TaskNotifier>(
                  builder: (BuildContext context, value, Widget child) {
                    return taskNotifier.dailyTasks[itemIndex].checklist.length ==
                            0
                        ? Container(child: Text("No checklist items yet"))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: taskNotifier
                                .dailyTasks[itemIndex].checklist.length,
                            itemBuilder: (BuildContext context, int i) {
                              String completed = taskNotifier
                                  .dailyTasks[itemIndex].checklist[i].checked
                                  .toString();
                              var checked = completed.toLowerCase() == "true"
                                  ? true
                                  : false;

                              return StatefulBuilder(
                                builder: (context, setState) =>
                                    CheckboxListTile(
                                  title: Text(taskNotifier
                                      .dailyTasks[itemIndex].checklist[i].title
                                      .toString()),
                                  value: checked,
                                  selected: false,
                                  onChanged: (bool value) {
                                    setState(() {
                                      checked = value;
                                      TaskApi taskApi = new TaskApi();
                                      String currentUserUID =
                                          Provider.of<AuthNotifier>(context,
                                                  listen: false)
                                              .user
                                              .uid;
                                      taskNotifier.dailyTasks[itemIndex]
                                          .checklist[i].checked = value;
                                      taskApi.checkListItem(
                                          currentUserUID,
                                          taskNotifier
                                              .dailyTasks[itemIndex].projectId,
                                          taskNotifier.dailyTasks[itemIndex],
                                          taskNotifier,
                                          itemIndex,
                                          checked,
                                          i);
                                    });
                                  },
                                  activeColor: Colors.green,
                                  checkColor: Colors.black,
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(int itemIndex) {
    slideDialog.showSlideDialog(
      context: context,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            Text("Add Item", style: AppThemes.display1),
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.edit,
                  color: AppThemeColours.TextFieldLineColor,
                ),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontSize: 26, color: AppThemeColours.TextFieldLineColor),
              cursorColor: Colors.white,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter checklist field';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                onPressed: () async {
                  Checklist checklist = new Checklist();
                  checklist.title = textEditingController.text;
                  checklist.checked = false;

                  String currentUserUID =
                      Provider.of<AuthNotifier>(context, listen: false)
                          .user
                          .uid;
                  TaskNotifier taskNotifier =
                      Provider.of<TaskNotifier>(context, listen: false);

                  TaskApi taskApi = new TaskApi();

                  taskApi.addChecklistItem(
                      currentUserUID,
                      taskNotifier.dailyTasks[itemIndex].projectId,
                      taskNotifier.dailyTasks[itemIndex],
                      checklist,
                      taskNotifier.dailyTasks[itemIndex].id,
                      taskNotifier,
                      itemIndex);

                  Navigator.of(context).pop();
                  setState(() {
                    taskApi.getTasks(taskNotifier, currentUserUID,
                        taskNotifier.taskList[itemIndex].projectId);
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 1.0,
                color: AppThemeColours.LightPurple,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: AppThemeColours.BlueGreenGradientBox,
                  child: Text(
                    "Save",
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  ),
                ),
                textColor: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.grey,
      backgroundColor: Colors.white,
    );
  }
}
