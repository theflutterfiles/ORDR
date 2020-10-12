import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/shared_methods.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final AuthService _auth = new AuthService();



class TasksList extends StatelessWidget {
  
final String documentReference;

Stream<QuerySnapshot> getTasksSnapshot(BuildContext context) async* {
  //* allows data to contsantly be open, always open stream

  final Firestore _firestore = Firestore.instance;
  final currentUserUID = await _auth.getCurrentUserUID();
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
        Align(
          alignment: Alignment.center,
          child: Container(
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
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) => Divider(),
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

  Widget _buildProjectCard(
      BuildContext context, DocumentSnapshot projectDocument) {
    DateTime created;
    DateTime startDate;
    DateTime endDate;
    DateTime lastEdited;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color(0xFFEBEBEB),
      child: InkWell(
        child: ListTile(
          onTap: () async => {},
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right:
                        new BorderSide(width: 1.0, color: Color(0xFF333333)))),
            child: CircleAvatar(
              backgroundColor: Color(0xFF333333),
              foregroundColor: Colors.white,
              child: Text(
                getInitial(string: projectDocument['title'], limitTo: 1),
              ),
            ),
          ),
          title: Text(
            projectDocument['title'],
            style: GoogleFonts.workSans(
                textStyle: AppThemes.listText, fontSize: 20),
          ),
          subtitle: Text(
            "Deadline: ${DateFormat('dd MMM yyyy').format(projectDocument['dueDate'].toDate()).toString()}",
            style: TextStyle(fontSize: 13),
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Color(0xFF333333), size: 30.0),
        ),
      ),
    );
  }
}
