import 'package:flutter/material.dart';

class AddTaskFormModel {
  String hintText;
  IconData icon;
  TextEditingController controller;
  bool readOnly;

  AddTaskFormModel(
      {@required this.hintText,
      @required this.icon,
      this.controller,
      this.readOnly,});
}

List<TextEditingController> textEditingControllers = new List();

List<AddTaskFormModel> addTaskFormItems = [
  AddTaskFormModel(
    icon: Icons.home_rounded,
    hintText: "Task Name",
    controller: new TextEditingController(),
    //readOnly: false
  ),
  AddTaskFormModel(
    icon: Icons.drive_file_rename_outline,
    hintText: "Description",
    controller: new TextEditingController(),
    //readOnly: false
  ),
  // AddTaskFormModel(
  //   icon: Icons.date_range,
  //   hintText: "Due Date",
  //   controller: new TextEditingController(),
  //   readOnly: true,
  // ),
];
