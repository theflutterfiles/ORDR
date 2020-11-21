import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/menu_drawer_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/screens/modals/add_project_modal.dart';
import 'package:flutter_app_mindful_lifting/screens/dashboard_view/ProjectView.dart';
import 'package:flutter_app_mindful_lifting/services/project_api.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/shared_methods.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void _showBottomSheet(context) {
  Project project = new Project();

  showBottomSheet(
      context: (context),
      builder: (BuildContext context) {
        return AddProjectModal(
          project: project,
        );
      });
}

class SearchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: Color(0xFF333333),
        size: 25.0,
      ),
      onPressed: () {},
    );
  }
}

class AddIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showBottomSheet(context);
      },
      icon: Icon(
        Icons.add,
        color: Color(0xFF333333),
        size: 25.0,
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, user, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 32.0, top: 8.0),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Geddit, \n" + user.user.displayName,
                style: GoogleFonts.poppins(
                  textStyle: AppThemes.display1,
                )),
            TextSpan(text: "\n\n\n\n\n"),
            TextSpan(text: "Projects", style: AppThemes.display2),
          ]),
        ),
      );
    });
  }
}

class ProjectsList extends StatefulWidget {
  @override
  _ProjectsListState createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  @override
  void initState() {
    ProjectNotifier _projectNotifier =
        Provider.of<ProjectNotifier>(context, listen: false);
    AuthNotifier _authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    String uid = _authNotifier.user.uid;

    ProjectApi projectApi = new ProjectApi();
    projectApi.getProjects(_projectNotifier, uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    ProjectNotifier _projectNotifier = Provider.of<ProjectNotifier>(context);

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 0.55 * screenHeight,
            width: 0.9 * screenWidth,
            decoration: AppThemeColours.BlueGreenGradientBox,
            child: Consumer<AuthNotifier>(builder: (context, user, child) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _projectNotifier.projectList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.white,
                      child: InkWell(
                        child: ListTile(
                          onTap: () {
                            _projectNotifier.currentProject =
                                _projectNotifier.projectList[index];
                                MenuDrawerNorifier menuDrawerNorifier = Provider.of<MenuDrawerNorifier>(context, listen: false);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ProjectDetailView();
                            }));
                            menuDrawerNorifier.setCurrentDrawer(1);
                          },
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(
                                        width: 1.0, color: Color(0xFF333333)))),
                            child: CircleAvatar(
                              backgroundColor:
                                  AppThemeColours.NavigationBarColor,
                              foregroundColor: Colors.white,
                              child: Text(
                                getInitial(
                                    string: _projectNotifier
                                        .projectList[index].projectName,
                                    limitTo: 1),
                              ),
                            ),
                          ),
                          title: Text(
                            _projectNotifier.projectList[index].projectName,
                            style: GoogleFonts.workSans(
                                textStyle: AppThemes.listText, fontSize: 20),
                          ),
                          subtitle: Text(
                            "Last Edited: ${DateFormat('dd MMM yyyy').format(_projectNotifier.projectList[index].lastEdited).toString()}",
                            style: TextStyle(fontSize: 13),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Color(0xFF333333), size: 30.0),
                        ),
                      ),
                    );
                  });
            }),
          ),
        ),
      ],
    );
  }
}
