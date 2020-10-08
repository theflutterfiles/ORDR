import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBarCard extends StatelessWidget {
  final int tasksCompleted;
  final String title;
  final int tasksRemaining;
  final double completionPercentage;

  const ProgressBarCard(
      {Key key,
      this.tasksCompleted,
      this.tasksRemaining,
      this.completionPercentage,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                //color: AppThemeColours.DarkPurple,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        title,
                        style: AppThemes.DashboardProgressText,
                      )),
                      Container(
                        child: Text(
                          completionPercentage.toString() + "%",
                          textAlign: TextAlign.left,
                          style: AppThemes.DashboardProgressText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    child: LinearPercentIndicator(
                      backgroundColor: Color(0xFFebebeb),
                      lineHeight: 10,
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: AppThemeColours.OrangeColour,
                      percent: completionPercentage / 100,
                    ),
                  ),
                ],
              ),
            ),
          
        ],
    );
  }
}
