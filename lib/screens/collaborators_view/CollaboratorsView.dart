import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/collaborators_view/widgets/SlideableWidget.dart';
import 'package:flutter_app_mindful_lifting/services/project_api.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/menu/collapsing_navigation_drawer.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/shared_methods.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class CollaboratorsView extends StatefulWidget {
  @override
  _CollaboratorsViewState createState() => _CollaboratorsViewState();
}

class _CollaboratorsViewState extends State<CollaboratorsView> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController instagramController = new TextEditingController();

  SlidableController slidableController;

  List<Collaborator> _collabs = List<Collaborator>();

  @override
  void initState() {
    ProjectNotifier projectNotifier =
        Provider.of<ProjectNotifier>(context, listen: false);
    String uid = Provider.of<AuthNotifier>(context, listen: false).user.uid;
    ProjectApi projectApi = new ProjectApi();
    projectApi.getProjects(projectNotifier, uid);

    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );

    if(projectNotifier.currentProject.collaborators.length != 0){
      _collabs = projectNotifier.currentProject.collaborators;
    }
    else _collabs = [];
    

    super.initState();
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    ProjectNotifier projectNotifier =
        Provider.of<ProjectNotifier>(context, listen: false);

    return Consumer<ProjectNotifier>(
      builder: (BuildContext context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    size: 40,
                    color: AppThemeColours.NavigationBarColor,
                  ),
                  color: Colors.black,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    _showDialog();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Color(0xFF333333),
                    size: 40.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    _showDialog();
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: Color(0xFF333333),
                    size: 35.0,
                  ),
                ),
              ),
            ],
          ),
          drawer: CollapsingNavigationDrawer("Collaborations"),
          drawerDragStartBehavior: DragStartBehavior.start,
          body: SingleChildScrollView(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppThemeColours.DashboardWhite,
              ),
              child: Consumer<ProjectNotifier>(
                builder: (BuildContext context, notifier, child) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: " Collaborations",
                                    style: GoogleFonts.poppins(
                                      textStyle: AppThemes.display1,
                                      //color: AppThemeColours.Purple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            width: screenWidth - 10,
                            height: screenHeight,
                            child: Consumer<ProjectNotifier>(
                              builder: (BuildContext context, value, child) {
                                return ListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return index == 0
                                        ? _searchBar()
                                        : _buildListTile(
                                            projectNotifier.currentProject
                                                .collaborators[index - 1],
                                            projectNotifier,
                                            index - 1,
                                          );
                                  },
                                  itemCount: projectNotifier
                                          .currentProject.collaborators.length +
                                      1,
                                );
                              },
                            )),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  _searchBar() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppThemeColours.LightPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children: [
        Icon(Icons.search_rounded, size: 35),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                hintText: "search...", border: InputBorder.none),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                ProjectNotifier projectNotifier =
                    Provider.of<ProjectNotifier>(context, listen: false);
                projectNotifier.currentProject.collaborators =
                    _collabs.where((collaborator) {
                  var collaboratorName = collaborator.name.toLowerCase();
                  return collaboratorName.contains(text);
                }).toList();
              });
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildListTile(
          Collaborator collaborator, ProjectNotifier projectNotifier, int index) =>
      SlideableWidget(
        index: index,
        collaborator: collaborator,
        projectNotifier: projectNotifier,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: AppThemeColours.Purple,
            child: Text(getInitial(string: collaborator.name, limitTo: 1)),
          ),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              collaborator.name,
              style: AppThemes.listText
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            collaborator.email != null || collaborator.email == ""
                ? Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(Icons.email_rounded)),
                      Text(
                        collaborator.email ?? "",
                      )
                    ],
                  )
                : SizedBox(height: 0),
            const SizedBox(
              height: 5,
            ),
            collaborator.number != null || collaborator.number == ""
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.phone),
                      ),
                      Text(
                        collaborator.number ?? "",
                      ),
                    ],
                  )
                : SizedBox(height: 0),
            const SizedBox(
              height: 5,
            ),
            collaborator.instagram != null || collaborator.instagram == ""
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(Icons.alternate_email),
                      ),
                      Text(
                        collaborator.instagram ?? "",
                      ),
                    ],
                  )
                : SizedBox(height: 0),
            Divider(
              color: AppThemeColours.TextFieldLineColor,
              endIndent: 16,
            )
          ]),
        ),
      );

  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            Text("Add Collaborator", style: AppThemes.display1),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.person_rounded,
                  color: AppThemeColours.TextFieldLineColor,
                ),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontSize: 26, color: AppThemeColours.TextFieldLineColor),
              cursorColor: Colors.white,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: AppThemeColours.TextFieldLineColor,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontSize: 26, color: AppThemeColours.TextFieldLineColor),
              cursorColor: Colors.white,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                labelText: "Number",
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.phone_rounded,
                  color: AppThemeColours.TextFieldLineColor,
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  fontSize: 26, color: AppThemeColours.TextFieldLineColor),
              cursorColor: Colors.white,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: instagramController,
              decoration: InputDecoration(
                labelText: "Instagram handle",
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.alternate_email_rounded,
                  color: AppThemeColours.TextFieldLineColor,
                ),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontSize: 26, color: AppThemeColours.TextFieldLineColor),
              cursorColor: Colors.white,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter instagram handle';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                onPressed: () async {
                  Collaborator collab = new Collaborator();
                  collab.name = nameController.text;
                  emailController.text.isEmpty
                      ? collab.email = null
                      : collab.email = emailController.text;
                  numberController.text.isEmpty
                      ? collab.number = null
                      : collab.number = numberController.text;
                  instagramController.text.isEmpty
                      ? collab.instagram = null
                      : collab.instagram = instagramController.text;

                  String currentUserUID =
                      Provider.of<AuthNotifier>(context, listen: false)
                          .user
                          .uid;
                  ProjectNotifier projectNotifier =
                      Provider.of<ProjectNotifier>(context, listen: false);

                  ProjectApi projectApi = new ProjectApi();

                  projectApi.addCollaborator(
                      currentUserUID,
                      projectNotifier.currentProject.id,
                      collab,
                      projectNotifier);

                  Navigator.of(context).pop();

                  nameController.clear();
                  numberController.clear();
                  emailController.clear();
                  instagramController.clear();
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
                    "Save",
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  ),
                ),
                textColor: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.grey,
      backgroundColor: Colors.white,
    );
  }
}
