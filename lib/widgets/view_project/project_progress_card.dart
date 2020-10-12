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
            child: Column(
                children: [
                  
                  Container(
                    //height: 40,
                    padding: EdgeInsets.only(right: 20),
                    child: CircularPercentIndicator(
                      lineWidth: 10.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text("50.0%"),
                    
                      backgroundColor: Color(0xFFebebeb),
                      animateFromLastPercent: true,
                      
                      progressColor: AppThemeColours.OrangeColour,
                      percent: completionPercentage / 100, radius: 100,
                    ),
                  ),
                ],
              ),
            ),
          
        ],
    );
  }
}
