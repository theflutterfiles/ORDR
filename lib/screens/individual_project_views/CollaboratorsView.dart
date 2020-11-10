import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:provider/provider.dart';

class CollaboratorsView extends StatefulWidget {
  @override
  _CollaboratorsViewState createState() => _CollaboratorsViewState();
}

class _CollaboratorsViewState extends State<CollaboratorsView> {
  @override
  Widget build(BuildContext context) {
    bool checked = false;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 58.0),
        child: CheckboxListTile(
          title: Text("Hi"),
          value: checked,
          selected: true,
          onChanged: (bool value) {
            setState(() {
              checked = value;
            });
          },
          activeColor: Colors.green,
          checkColor: Colors.black,
        ),
      ),
    );
  }
}
