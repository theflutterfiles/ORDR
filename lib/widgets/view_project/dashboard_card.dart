import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';

class CustomDashboardCard extends StatelessWidget {
  final String title;
  final Icon icon;
  //final Action onNavigationSelection;
  final String content;
  final LinearGradient gradient;

  const CustomDashboardCard(
      {Key key,
      @required this.title,
      this.icon,
      this.content,
      this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 16),
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
        ),
      ],
    );
  }
}
