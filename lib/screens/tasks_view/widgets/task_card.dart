import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Checklist.dart';
import 'package:flutter_app_mindful_lifting/models/dashboard_card.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/task_api.dart';
import 'package:flutter_app_mindful_lifting/styles/box_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/screens/dashboard_view/widgets/dashboard_icons.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/shared_methods.dart';
import 'package:flutter_app_mindful_lifting/screens/dashboard_view/widgets/dashboard_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final int index;

  const TaskCard({Key key, this.index}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                width: 230,
                height: 120,
                margin: EdgeInsets.all(5),
                decoration:
                    nMbox.copyWith(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: AppThemeColours.LightPurple,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    taskNotifier.dailyTasks[widget.index].title +
                                        "\n\n",
                                style: GoogleFonts.poppins(
                                    textStyle: AppThemes.display1
                                        .copyWith(fontSize: 20)),
                              ),
                              TextSpan(
                                text:
                                    "Due: ${DateFormat('dd MMM yyyy').format(taskNotifier.dailyTasks[widget.index].dueDate).toString()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppThemeColours.TextFieldLineColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          width: 80,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            alignment: Alignment.topRight,
                            onPressed: () =>
                                _showEditTaskBottomSheet(widget.index),
                          ))
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    alignment: Alignment.bottomRight,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.all(5),
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.all(5),
                      decoration: nMbox.copyWith(shape: BoxShape.circle),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(10),
                          color: (taskNotifier.dailyTasks[widget.index].status ==
                                  false)
                              ? Colors.white
                              : AppThemeColours.DoneGreen,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.check,
                            color:
                                (taskNotifier.dailyTasks[widget.index].status ==
                                        false)
                                    ? Colors.grey
                                    : Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 100,
                    height: 40,
                    margin: EdgeInsets.all(5),
                    decoration:
                        nMbox.copyWith(borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (taskNotifier.dailyTasks[widget.index].status) ==
                                false
                            ? AppThemeColours.Yellow
                            : AppThemeColours.DoneGreen,
                      ),
                      child: Text(
                        (taskNotifier.dailyTasks[widget.index].status) == false
                            ? "Open"
                            : "Done",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: 100,
                    height: 40,
                    margin: EdgeInsets.all(5),
                    decoration:
                        nMbox.copyWith(borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (taskNotifier.dailyTasks[widget.index].priority ==
                                "low")
                            ? Colors.green
                            : (taskNotifier.dailyTasks[widget.index].priority ==
                                    "medium")
                                ? Colors.orange
                                : Colors.red,
                      ),
                      child: Text(
                        (taskNotifier.dailyTasks[widget.index].priority == "low")
                            ? "Low"
                            : (taskNotifier.dailyTasks[widget.index].priority ==
                                    "medium")
                                ? "Medium"
                                : "High",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 20, top: 25),
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     taskNotifier.dailyTasks[index].description,
          //   ),
          // ),
        ],
      ),
    );
  }

  void _showEditTaskBottomSheet(int itemIndex) {
    slideDialog.showSlideDialog(
      context: context,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            Text("Edit Task", style: AppThemes.display1),
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
                  return 'Enter description';
                }
                //Navigator.of(context).pop();
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

                  // taskApi.addChecklistItem(
                  //     currentUserUID,
                  //     taskNotifier.dailyTasks[itemIndex].projectId,
                  //     taskNotifier.dailyTasks[itemIndex],
                  //     checklist,
                  //     taskNotifier.dailyTasks[itemIndex].id,
                  //     taskNotifier,
                  //     itemIndex);

                  //Navigator.of(context).pop();
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
