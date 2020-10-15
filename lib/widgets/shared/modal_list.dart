import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/add_task_model.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/add_task_form_list.dart';

class ModalList extends StatefulWidget {
  @override
  _ModalListState createState() =>
      _ModalListState();
}

class _ModalListState extends State<ModalList> {

  int currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: AppThemeColours.NavigationBarColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFc4c4c4),
            blurRadius: 1.0,
            spreadRadius: 0.0,
            offset: Offset(1.0, 1.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: AppThemes.ModalFieldPadding,
                    child: AddTaskFormListTitle(
                      icon: addTaskFormItems[index].icon,
                      hintText: addTaskFormItems[index].hintText,
                      readOnly: addTaskFormItems[index].readOnly,
                    ),
                  );
                },
                itemCount: addTaskFormItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  
}
