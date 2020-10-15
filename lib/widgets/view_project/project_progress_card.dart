import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBarCard extends StatelessWidget {
  final int tasksCompleted;
  final String title;
  final int tasksRemaining;
  final double completionPercentage;
  final double radius;
  final double lineWidth;
  final String text;
  final Color colour;

  const ProgressBarCard(
      {Key key,
      this.tasksCompleted,
      this.tasksRemaining,
      this.completionPercentage,
      this.radius,
      this.lineWidth,
      this.title,
      this.text,
      this.colour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, bottom: 20),
      child: CircularPercentIndicator(
        lineWidth: lineWidth,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(text),
        backgroundColor: Color(0xFFebebeb),
        animateFromLastPercent: true,
        progressColor: colour,
        percent: completionPercentage / 100,
        radius: radius,
      ),
    );
  }
}
