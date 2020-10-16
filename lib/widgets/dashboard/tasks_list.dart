import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/view_project/project_progress_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class TasksList extends StatelessWidget {
  final String documentReference;

  Stream<QuerySnapshot> getTasksSnapshot(BuildContext context) async* {
    //* allows data to contsantly be open, always open stream

    final Firestore _firestore = Firestore.instance;
    final currentUserUID = Provider.of<AuthNotifier>(context).user.uid;
    yield* _firestore
        .collection("users")
        .document(currentUserUID)
        .collection("projects")
        .document(this.documentReference)
        .collection("tasks")
        .snapshots();
  }

  const TasksList({Key key, this.documentReference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          //padding: EdgeInsets.all(20),
          height: 0.55 * screenHeight,
          width: 0.9 * screenWidth,
          //decoration: AppThemeColours.BlueGreenGradientBox,
          child: StreamBuilder(
              stream: getTasksSnapshot(context),
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
                      height: 120,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) =>
                              _buildProjectCard(
                                  context, snapshot.data.documents[index])));
                }
              }),
        ),
      ],
    );
  }

  Widget _buildProjectCard(
      BuildContext context, DocumentSnapshot projectDocument) {
    DateTime created;
    DateTime startDate;
    DateTime endDate;
    DateTime lastEdited;

    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        child: ListTile(
          onTap: () async => {},
          leading: Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: Container(
              alignment: Alignment.center,
              width: 90,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (projectDocument['status']) == true
                    ? AppThemeColours.Yellow
                    : AppThemeColours.DoneGreen,
              ),
              child: Text(
                (projectDocument['status']) == true ? "In Progress" : "Done",
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: projectDocument['title'] + "\n",
                      style: GoogleFonts.poppins(
                        textStyle: AppThemes.listText.copyWith(fontSize: 18),
                      ),
                    ),
                    TextSpan(
                      text:
                          "Due: ${DateFormat('dd MMM yyyy').format(projectDocument['dueDate'].toDate()).toString()}",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppThemeColours.TextFieldLineColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ProgressBarCard(
                  completionPercentage:
                      (projectDocument['status']) == true ? 75.0 : 100,
                  lineWidth: 3.0,
                  radius: 50,
                  text: (projectDocument['status']) == true ? "75%" : "100%",
                  colour: (projectDocument['status']) == true
                      ? AppThemeColours.Purple
                      : AppThemeColours.DoneGreen,
                ),
              ),
            ],
          ),
        ),
      ),
      //trailing: Icon(Icons.circle,
      //color: (projectDocument['status']) == true ? Colors.green : Colors.red,
    );
  }
}
