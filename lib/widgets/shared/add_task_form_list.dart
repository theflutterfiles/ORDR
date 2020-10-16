import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';

class AddTaskFormListTitle extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color textLineColour;
  final IconData icon;
  final bool readOnly;
  final Function onTap;

  const AddTaskFormListTitle(
      {Key key,
      this.controller,
      this.hintText,
      this.textLineColour,
      this.icon,
      this.readOnly = false,
      this.onTap})
      : super(key: key);

  @override
  _AddTaskFormListTitleState createState() => _AddTaskFormListTitleState();
}

class _AddTaskFormListTitleState extends State<AddTaskFormListTitle> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {},
      controller: widget.controller,
      readOnly: widget.readOnly,
      style: TextStyle(
        color: AppThemeColours.TextFieldLineColor,
      ),
      decoration: InputDecoration(
          focusColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          //contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            widget.icon,
            color: AppThemeColours.TextFieldLineColor,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppThemeColours.TextFieldLineColor,
          )),
    );
  }
}
