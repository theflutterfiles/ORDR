import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/home_page/home_page_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';

class AddProjectModal extends StatelessWidget {
  final Project project;

  AddProjectModal({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TextEditingController _projectNameTextController =
        new TextEditingController();
    TextEditingController _missionTextController = new TextEditingController();

    return Expanded(
      child: Card(
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
                          padding: const EdgeInsets.only(bottom: 10),
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
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10, right: 20.0),
                              child: RaisedButton(
                                onPressed: () {

                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  child: Text(
                                    "Start Date",
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                                color: Color(0xff333333),
                                textColor: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: RaisedButton(
                                onPressed: () {

                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  child: Text(
                                    "End Date",
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                                color: Color(0xff333333),
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        RaisedButton(
                          onPressed: () {
                            project.projectName = _projectNameTextController.text;
                            project.mission = _missionTextController.text;
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
          ),
    );
  }
}
