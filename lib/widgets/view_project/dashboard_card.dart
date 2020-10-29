import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:provider/provider.dart';

class CustomDashboardCard extends StatelessWidget {
  final String title;
  final Icon icon;
  //final Action onNavigationSelection;

  final LinearGradient gradient;
  final Widget textWidget;

  const CustomDashboardCard(
      {Key key,
      @required this.title,
      this.icon,
      this.gradient,
      this.textWidget})
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
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     blurRadius: 2.0,
              //     spreadRadius: 0.0,
              //     offset: Offset(2.0, 2.0), // shadow direction: bottom right
              //   )
              // ],
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
                        child: Consumer<ProjectNotifier>(
                          builder: (context, notifier, child) {
                            return textWidget;
                          },
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
