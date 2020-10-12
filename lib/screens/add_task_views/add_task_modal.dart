import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';
import 'package:flutter_app_mindful_lifting/models/add_task_model.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/add_task_form_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTaskModal extends StatefulWidget {
  final Task task;
  final String projectName;
  final String documentReference;

  AddTaskModal(
      {Key key,
      @required this.task,
      @required this.projectName,
      this.documentReference})
      : super(key: key);

  @override
  _AddTaskModalState createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  TextEditingController _dueDateTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String due = "Due Date";

    return Stack(
      children: [
        Container(
          height: screenHeight,
          width: screenWidth,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Add Task",
                                style: GoogleFonts.poppins(
                                  textStyle: AppThemes.display1,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppThemeColours.TextFieldLineColor,
                                  size: 30,
                                ),
                                onPressed: () => {Navigator.pop(context), 
                                _dueDateTextController.clear(),
                                textEditingControllers.clear(),
                                }, 
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 160,
                          width: screenWidth,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              textEditingControllers
                                  .add(new TextEditingController());
                              return Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: AddTaskFormListTitle(
                                  icon: addTaskFormItems[index].icon,
                                  hintText: addTaskFormItems[index].hintText,
                                  controller: textEditingControllers[index],
                                ),
                              );
                            },
                            itemCount: addTaskFormItems.length,
                          ),
                        ),
                        TextField(
                          controller: _dueDateTextController,
                          readOnly: true,
                          onTap: () async {
                            final datePicked = await showDatePicker(
                              context: (context),
                              initialDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(Duration(days: 365 * 10)),
                              firstDate:
                                  DateTime.now().add(Duration(days: -365)),
                            );
                            if (datePicked != null) {
                              setState(() {
                                widget.task.dueDate = datePicked;
                              });
                              _dueDateTextController.text =
                                  DateFormat('dd/MM/yyyy').format(datePicked);
                            } else {
                              return;
                            }
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Color(0xFF333333),
                            ),
                            hintText: '$due',
                            hintStyle: TextStyle(
                              color: Color(0xFF333333),
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: RaisedButton(
                            onPressed: () async {
                              widget.task.title =
                                  textEditingControllers[0].text;
                              widget.task.description =
                                  textEditingControllers[1].text;
                              widget.task.created = DateTime.now();

                              final currentUserUID =
                                  Provider.of<User>(context, listen: false).uid;
                              final Firestore _firestore = Firestore.instance;

                              await _firestore
                                  .collection("users/$currentUserUID/projects")
                                  .document(widget.documentReference)
                                  .collection("tasks").add(widget.task.toJson());

                                  _dueDateTextController.clear();
                                  textEditingControllers.clear();
                        
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 1.0,
                            color: Color(0xFF3cebb6),
                            child: Container(
                              height: 50,
                              width: 80,
                              decoration: AppThemeColours.BlueGreenGradientBox,
                              child: Center(
                                child: Text(
                                  "Add Task",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            textColor: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
