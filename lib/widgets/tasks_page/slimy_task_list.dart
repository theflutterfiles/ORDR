import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:provider/provider.dart';

class TaskCardList extends StatelessWidget {
  final int index;

  const TaskCardList({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);

    int checkListLength = taskNotifier.taskList[index].checklist.length;

    return Consumer<TaskNotifier>(builder: (context, notifier, child) {
      return Column(
        children: [
          ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: checkListLength,
              itemBuilder: (BuildContext context, int i) {
                //return CheckboxListTile(
                //title: taskNotifier.taskList[index].checklist[i],
                //value: null, onChanged: null);
              }),
        ],
      );
    });
  }
}
