import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/dashboard_card.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/styles/box_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/dashboard/dashboard_icons.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/shared_methods.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/dashboard_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final int index;

  const TaskCard({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: 200,
                height: 90,
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
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: taskNotifier.taskList[index].title + "\n\n",
                          style: GoogleFonts.poppins(
                              textStyle:
                                  AppThemes.display1.copyWith(fontSize: 20)),
                        ),
                        TextSpan(
                          text:
                              "Due: ${DateFormat('dd MMM yyyy').format(taskNotifier.taskList[index].dueDate).toString()}",
                          style: TextStyle(
                              fontSize: 15,
                              color: AppThemeColours.TextFieldLineColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  
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
                        color: (taskNotifier.taskList[index].status) == false
                            ? AppThemeColours.Yellow
                            : AppThemeColours.DoneGreen,
                      ),
                      child: Text(
                        (taskNotifier.taskList[index].status) == false
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
                        color: (taskNotifier.taskList[index].priority == "low")
                            ? AppThemeColours.DoneGreen
                            : (taskNotifier.taskList[index].priority == "medium")
                            ? AppThemeColours.OrangeColour
                            : Colors.red,
                      ),
                      child: Text(
                        (taskNotifier.taskList[index].priority == "low")
                            ? "Low"
                            : (taskNotifier.taskList[index].priority == "medium")
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
          Container(
            padding: EdgeInsets.only(left: 20, top: 25),
            alignment: Alignment.topLeft,
            child: Text(
              taskNotifier.taskList[index].description,
            ),
          ),
        ],
      ),
    );
  }
}
