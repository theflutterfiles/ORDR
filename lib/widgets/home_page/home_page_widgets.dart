import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/screens/add_project_views/add_project_modal.dart';
import 'package:flutter_app_mindful_lifting/screens/individual_project_views/ProjectView.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/shared_methods.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final AuthService _auth = new AuthService();

Stream<QuerySnapshot> getProjectsSnapshot(BuildContext context) async* {
  //* allows data to contsantly be open, always open stream

  final Firestore _firestore = Firestore.instance;
  final currentUserUID = await _auth.getCurrentUserUID();
  yield* _firestore
      .collection('users')
      .document(currentUserUID)
      .collection('projects')
      .snapshots();
}

void _showBottomSheet(context) {
  Project project = new Project(null, null, null, null, null, null, null, null,
      null, null, null, null, null);

  showBottomSheet(
      context: (context),
      builder: (BuildContext context) {
        return AddProjectModal(
          project: project,
        );
      });
}

class MenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.menu,
          color: Color(0xFF333333),
          size: 25.0,
        ),
        onPressed: () async {
          await _auth.signOut();
        });
  }
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
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, top: 8.0),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "Geddit",
              style: GoogleFonts.poppins(
                textStyle: AppThemes.display1,
              )),
          TextSpan(text: "\n\n"),
          TextSpan(text: "Projects", style: AppThemes.display2),
        ]),
      ),
    );
  }
}

class ProjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 0.55 * screenHeight,
            width: 0.9 * screenWidth,
            decoration: AppThemeColours.BlueGreenGradientBox,
            child: StreamBuilder(
                stream: getProjectsSnapshot(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SpinKitRing(
                        color: Colors.teal,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) =>
                                _buildProjectCard(
                                    context, snapshot.data.documents[index])));
                  }
                }),
          ),
        ),
      ],
    );
  }
}

Widget _buildProjectCard(
    BuildContext context, DocumentSnapshot projectDocument) {
  DateTime created;
  DateTime startDate;
  DateTime endDate;
  DateTime lastEdited;

  final Project project = Project.fromSnapshot(projectDocument);

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    color: Colors.white,
    child: InkWell(
      child: ListTile(
        onTap: () async => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProjectDetailView(
                        project: project,
                        documentReference: projectDocument.documentID,
                      ))),
        },
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Color(0xFF333333)))),
          child: CircleAvatar(
            backgroundColor: AppThemeColours.NavigationBarColor,
            foregroundColor: Colors.white,
            child: Text(
              getInitial(string: projectDocument['projectName'], limitTo: 1),
            ),
          ),
        ),
        title: Text(
          projectDocument['projectName'],
          style:
              GoogleFonts.workSans(textStyle: AppThemes.listText, fontSize: 20),
        ),
        subtitle: Text(
          "Last Edited: ${DateFormat('dd MMM yyyy').format(projectDocument['lastEdited'].toDate()).toString()}",
          style: TextStyle(fontSize: 13),
        ),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: Color(0xFF333333), size: 30.0),
      ),
    ),
  );
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Logo.png',
      fit: BoxFit.contain,
    );
  }
}

class DraggableScrollableProjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 0.85,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              color: Color(0xFF333333),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                ),
              ]),
          //child:
        );
      },
    );
  }
}
