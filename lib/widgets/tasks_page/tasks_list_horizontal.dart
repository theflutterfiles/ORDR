import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/styles/box_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/tasks_page/task_card.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/project_progress_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

class TasksListHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);

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
                    return Flexible(
                      child: SlimyCard(
                        color: Colors.white,
                        width: screenWidth * 0.9,
                        topCardHeight: screenHeight * 0.2,
                        topCardWidget: TaskCard(
                          index: index,
                        ),
                      ),
                    );
                  });
            },
          )),
    ]);
  }
}
