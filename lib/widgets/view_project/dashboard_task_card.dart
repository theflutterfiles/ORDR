import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';

class CustomDashboardTaskCard extends StatelessWidget {

  final String title;
  final Icon icon;
  //final Action onNavigationSelection;
  final String content;
  final Color colour;

  const CustomDashboardTaskCard(
      {Key key,
      @required this.title,
      this.icon,
      @required this.content,
      @required this.colour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: colour, borderRadius: BorderRadius.circular(20),
            ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                    child: icon,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 16),
                    child: Text(
                      title,
                      style: AppThemes.DashboardCardTitleText,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
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