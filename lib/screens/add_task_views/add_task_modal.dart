import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/models/Task.dart';
import 'package:flutter_app_mindful_lifting/models/add_task_model.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/project_api.dart';
import 'package:flutter_app_mindful_lifting/services/task_api.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/add_task_form_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTaskModal extends StatefulWidget {
  @override
  _AddTaskModalState createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  TextEditingController _dueDateTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: true);

    String due = "Due Date";

    Task task = new Task();

    final currentUserUID =
        Provider.of<AuthNotifier>(context, listen: false).user.uid;

    final TaskApi taskApi = new TaskApi();

    final ProjectNotifier projectNotifier =
        Provider.of<ProjectNotifier>(context, listen: false);

    return Stack(
      children: [
        Container(
          height: screenHeight,
          width: screenWidth,
          child: Card(
            //color: AppThemeColours.DashboardWhite,
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
                                onPressed: () => {
                                  Navigator.pop(context),
                                  _dueDateTextController.clear(),
                                  textEditingControllers.clear(),
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 140,
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
                        SizedBox(height: 20),
                        Container(
                            child: CustomRadioButton(
                          buttonLables: [
                            "Low",
                            "Medium",
                            "High",
                          ],
                          buttonValues: [
                            "low",
                            "medium",
                            "high",
                          ],
                          radioButtonValue: (values) => task.priority = values,
                          height: 43,
                          unSelectedBorderColor: Colors.grey,
                          enableShape: true,
                          horizontal: false,
                          width: screenWidth / 4,
                          padding: 5,
                          unSelectedColor: Colors.white,
                          elevation: 0,
                          selectedBorderColor: AppThemeColours.OrangeColour,
                          selectedColor: AppThemeColours.OrangeColour,
                        )),
                        SizedBox(height: 20),
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
                              task.dueDate = datePicked;

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
                              task.title = textEditingControllers[0].text;
                              task.description = textEditingControllers[1].text;
                              task.created = DateTime.now();
                              task.lastEdited = task.created;
                              task.status = false;
                              ProjectApi projectApi = new ProjectApi();

                            
                              
                              

                              task.projectId =
                                  projectNotifier.currentProject.id;

                                  projectApi.updateOpenTasks(task.projectId, currentUserUID, projectNotifier, projectNotifier.currentProject);

                              _dueDateTextController.clear();
                              textEditingControllers.clear();

                              taskApi.addTask(
                                  currentUserUID, task.projectId, task, taskNotifier);

                              taskNotifier.addTask(task);

                        
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 1.0,
                            color: AppThemeColours.LightPurple,
                            child: Container(
                              height: 50,
                              width: 80,
                              color: AppThemeColours.LightPurple,
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
