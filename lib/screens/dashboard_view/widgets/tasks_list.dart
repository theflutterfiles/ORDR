import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/screens/dashboard_view/widgets/project_progress_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: true);

    return Stack(children: <Widget>[
      Container(
          //padding: EdgeInsets.all(20),
          height: 0.55 * screenHeight,
          width: 0.9 * screenWidth,
          //decoration: AppThemeColours.BlueGreenGradientBox,
          child: Consumer<TaskNotifier>(
            builder: (BuildContext context, value, Widget child) {
              return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: taskNotifier.taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          onTap: () async => {},
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 17.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: (taskNotifier.taskList[index].status) ==
                                        false
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
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: taskNotifier.taskList[index].title +
                                          "\n",
                                      style: GoogleFonts.poppins(
                                        textStyle: AppThemes.listText
                                            .copyWith(fontSize: 18),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "Due: ${DateFormat('dd MMM yyyy').format(taskNotifier.taskList[index].dueDate).toString()}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppThemeColours
                                              .TextFieldLineColor),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: ProgressBarCard(
                                  completionPercentage:
                                      (taskNotifier.taskList[index].status) ==
                                              false
                                          ? 75.0
                                          : 100,
                                  lineWidth: 3.0,
                                  radius: 50,
                                  text: (taskNotifier.taskList[index].status) ==
                                          false
                                      ? "75%"
                                      : "100%",
                                  colour:
                                      (taskNotifier.taskList[index].status) ==
                                              true
                                          ? AppThemeColours.DoneGreen
                                          : AppThemeColours.Purple,
                                ),
                              ),
                            ],
                          ),
                          //trailing: Icon(Icons.circle,
                          //color: (projectDocument['status']) == true ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  });
            },
          ))
    ]);
  }
}
