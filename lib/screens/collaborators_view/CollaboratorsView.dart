import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/project_api.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/screens/collaborators_view/widgets/CollaboratorsListView.dart';
import 'package:flutter_app_mindful_lifting/screens/collaborators_view/widgets/SlideableWidget.dart';
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
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
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
                  width: screenWidth,
                  height: screenHeight,
                  child: Consumer<ProjectNotifier>(
                    builder:
                        (BuildContext context, projectNotifier, Widget child) {
                      return AlphabeticListView(
                          headers: projectNotifier.collabsList
                              .map((e) => e.name)
                              .toList(),
                          itemCount: projectNotifier.collabsList.length,
                          list: projectNotifier.collabsList,
                          listKey: "name",
                          item: (data, index) => SlideableWidget(
                                email: Collaborator.fromMap(data).email,
                                instagram: Collaborator.fromMap(data).instagram,
                                projectNotifier: projectNotifier,
                                collaborator: Collaborator.fromMap(data),
                                child:
                                    _buildListTile(Collaborator.fromMap(data)),
                              ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(Collaborator collaborator) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppThemeColours.Purple,
          child: Text(getInitial(string: collaborator.name, limitTo: 1)),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            collaborator.name,
            style: AppThemes.listText
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          collaborator.email != null
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
          collaborator.number != null
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
          collaborator.instagram != null
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
          ) : SizedBox(height : 0),
          Divider(color: AppThemeColours.TextFieldLineColor,)
        ]),
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
                  collab.email = emailController.text;
                  collab.number = numberController.text;
                  collab.instagram = instagramController.text;

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
