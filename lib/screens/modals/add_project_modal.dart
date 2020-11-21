import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/home_view/homeScreen.dart';
import 'package:flutter_app_mindful_lifting/services/project_api.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProjectModal extends StatefulWidget {
  final Project project;

  AddProjectModal({Key key, @required this.project}) : super(key: key);

  @override
  _AddProjectModalState createState() => _AddProjectModalState();
}

class _AddProjectModalState extends State<AddProjectModal> {
  ProjectApi projectApi = new ProjectApi();

  TextEditingController _projectNameTextController =
      new TextEditingController();
  TextEditingController _missionTextController = new TextEditingController();
  TextEditingController _startDateTextController = new TextEditingController();
  TextEditingController _endDateTextController = new TextEditingController();
  TextEditingController _budgetTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    String start = "Start";
    String end = "End";

    ProjectNotifier projectNotifier = Provider.of<ProjectNotifier>(context, listen:false);

    return Container(
      height: screenHeight,
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
                            "Add Project",
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
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextField(
                        controller: _projectNameTextController,
                        style: TextStyle(
                          color: Color(0xFF333333),
                        ),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.folder_special,
                              color: Color(0xFF333333),
                            ),
                            hintText: 'Project Name',
                            hintStyle: TextStyle(
                              color: Color(0xFF333333),
                              fontFamily: 'OpenSans',
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextField(
                        controller: _missionTextController,
                        style: TextStyle(
                          color: Color(0xFF333333),
                        ),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.stars,
                              color: Color(0xFF333333),
                            ),
                            hintText: 'Mission',
                            hintStyle: TextStyle(
                              color: Color(0xFF333333),
                              fontFamily: 'OpenSans',
                            )),
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: TextField(
                                controller: _startDateTextController,
                                readOnly: true,
                                onTap: () async {
                                  final datePicked = await showDatePicker(
                                    context: (context),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(Duration(days: 365 * 10)),
                                    firstDate: DateTime.now()
                                        .add(Duration(days: -365)),
                                  );
                                  if (datePicked != null) {
                                    setState(() {
                                      widget.project.startDate = datePicked;
                                    });
                                    _startDateTextController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(datePicked);
                                  } else {
                                    return;
                                  }
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: Color(0xFF333333),
                                  ),
                                  hintText: '$start',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF333333),
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _endDateTextController,
                              readOnly: true,
                              onTap: () async {
                                final datePicked = await showDatePicker(
                                  context: (context),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(Duration(days: 365 * 10)),
                                  firstDate:
                                      DateTime.now().add(Duration(days: -365)),
                                );
                                if (datePicked != null) {
                                  setState(() {
                                    widget.project.endDate = datePicked;
                                  });
                                  _endDateTextController.text =
                                      DateFormat('dd/MM/yyyy')
                                          .format(datePicked);
                                } else {
                                  return;
                                }
                              },
                              decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                    color: Color(0xFF333333),
                                  ),
                                  hintText: '$end',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF333333),
                                    fontFamily: 'OpenSans',
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: TextField(
                        controller: _budgetTextController,
                        style: TextStyle(
                          color: Color(0xFF333333),
                        ),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.monetization_on,
                              color: Color(0xFF333333),
                            ),
                            hintText: 'Initial Budget',
                            hintStyle: TextStyle(
                              color: Color(0xFF333333),
                              fontFamily: 'OpenSans',
                            )),
                        //inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        onPressed: () async {
                          widget.project.projectName =
                              _projectNameTextController.text;
                          widget.project.mission = _missionTextController.text;
                          widget.project.created = DateTime.now();
                          widget.project.lastEdited = DateTime.now();
                          widget.project.budget =
                              double.parse(_budgetTextController.text);

                          final currentUserUID =
                              Provider.of<AuthNotifier>(context, listen: false)
                                  .user
                                  .uid;

                          projectApi.addProject(currentUserUID, widget.project, projectNotifier);
                          

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //   return HomePage();
                          // }));
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 1.0,
                        color: AppThemeColours.LightPurple,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: AppThemeColours.BlueGreenGradientBox,
                          child: Text(
                            "Geddit!",
                            style: TextStyle(
                              fontFamily: 'OpenSans', fontSize: 20
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
    );
  }
}
