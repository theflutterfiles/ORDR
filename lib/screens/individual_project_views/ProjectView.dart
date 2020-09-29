import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/widgets/home_page/home_page_widgets.dart';


class ProjectView extends StatelessWidget {

  final AuthService _auth = new AuthService();

  Future<QuerySnapshot> getProject(BuildContext context) async { //* allows data to contsantly be open, always open stream

    final Firestore _firestore = Firestore.instance;
    final currentUserUID = await _auth.getCurrentUserUID();
    return  _firestore
        .collection('users')
        .document(currentUserUID)
        .collection('projects')
        .getDocuments();
  }



  Project project;
  String projectName;

  ProjectView({Key key, this.projectName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEbEBEB),
      appBar: AppBar(
        title: Text(project.projectName),
        leading: MenuIcon(),
        actions: <Widget>[
          AddIcon(),
          SearchIcon(),
        ],
      ),
    );
  }
}
