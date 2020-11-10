import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';

class CustomDashboardAddTaskCard extends StatelessWidget {
  final String title;
  final Icon icon;
  //final Action onNavigationSelection;
  final String content;
  final LinearGradient gradient;

  const CustomDashboardAddTaskCard(
      {Key key,
      @required this.title,
      this.icon,
      @required this.content,
      this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 16),
                      child: Text(
                        title,
                        style: AppThemes.DashboardCardTitleText.copyWith(fontSize: 30),
                      ),
                    ),
                  ),
                  Container(child: icon, padding: EdgeInsets.all(10),),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 16),
                    child: Text(
                      content,
                      style: (content.contains("\$")
                          ? AppThemes.DashboardCardBudgetNumber
                          : AppThemes.DashboardCardContentText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDashboardAddTaskCard2 extends StatelessWidget {
  final String title;
  final Icon icon;
  //final Action onNavigationSelection;
  final String content;
  final LinearGradient gradient;

  const CustomDashboardAddTaskCard2(
      {Key key,
      this.title,
      this.icon,
      @required this.content,
      this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top:10),
        child: Column(
          children: [
            Expanded(
              child:
              Column(children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 10),
                      child: Text(
                        "Show\nTasks",
                        style: AppThemes.DashboardCardTitleText.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(child: icon, padding: EdgeInsets.all(10),),
                  ],)
            ),
          ],
        ),
    );
  }
}