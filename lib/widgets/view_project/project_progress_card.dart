import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBarCard extends StatelessWidget {

final int tasksCompleted;
final String title;
final int tasksRemaining;
final double completionPercentage;

  const ProgressBarCard({Key key, this.tasksCompleted, this.tasksRemaining, this.completionPercentage, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children:[
        Container(
          padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppThemeColours.DarkPurple,
              borderRadius: BorderRadius.circular(20)),
            child: Column(
               children:[ Row(
              children:[
                Expanded(child: Text(title, style: AppThemes.DashboardCardTitleText,)),
                Container(              
                  child: Text(completionPercentage.toString()+"%", textAlign: TextAlign.left, style: AppThemes.DashboardCardTitleText,),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16),
              ),
              ], 
          ),
          SizedBox(height: 15,),
          LinearPercentIndicator(
          backgroundColor: AppThemeColours.DashboardColor,
          lineHeight: 20,
          progressColor: AppThemeColours.GreenHighlight,
          percent: completionPercentage / 100,
          ),
           ],
            ),
        ),                
      ],),
    );
  }
}