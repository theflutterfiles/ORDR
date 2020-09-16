import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/home_page/home_page_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:intl/intl.dart';

class AddProjectModal extends StatefulWidget {
  final Project project;

  AddProjectModal({Key key, @required this.project}) : super(key: key);

  @override
  _AddProjectModalState createState() => _AddProjectModalState();
}

class _AddProjectModalState extends State<AddProjectModal> {

  TextEditingController _projectNameTextController =
  new TextEditingController();
  TextEditingController _missionTextController = new TextEditingController();
  TextEditingController _startDateTextController = new TextEditingController();
  TextEditingController _endDateTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    DateTime startDate = DateTime.now();
    DateTime endDate;
    DateTime created;
    DateTime lastEdited;

    String start = "Start";
    String end = "End";

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "Add Project",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: AppThemes.display1,
                    ),
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
                                lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                                firstDate: DateTime.now().add(Duration(days: -365)),
                              );
                              if (startDate != null) {
                                setState(() {
                                  startDate = datePicked;
                                });
                                _startDateTextController.text =
                                    DateFormat('dd/MM/yyyy').format(startDate).toString();
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
                                hintText: '${start}',
                                hintStyle: TextStyle(
                                  color: Color(0xFF333333),
                                  fontFamily: 'OpenSans',
                                )
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
                              lastDate: DateTime.now().add(Duration(days: 365 * 10)),
                              firstDate: DateTime.now().add(Duration(days: -365)),
                            );
                            if (datePicked != null) {
                              setState(() {
                                endDate = datePicked;
                              });
                              _endDateTextController.text =
                                  DateFormat('dd/MM/yyyy').format(endDate).toString();
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
                              hintText: '${end}',
                              hintStyle: TextStyle(
                                color: Color(0xFF333333),
                                fontFamily: 'OpenSans',
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    widget.project.projectName =
                        _projectNameTextController.text;
                    widget.project.mission = _missionTextController.text;
                    widget.project.startDate = _startDateTextController as DateTime;
                    widget.project.endDate = _endDateTextController as DateTime;
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xFF3cebb6),
                  child: Container(
                    decoration: AppThemeColours.BlueGreenGradientBox,
                    child: Text(
                      "Lets go!",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  textColor: Color(0xFF333333),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
