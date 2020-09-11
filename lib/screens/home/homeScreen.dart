import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/screens/account.dart';
import 'package:flutter_app_mindful_lifting/screens/addProject.dart';
import 'package:flutter_app_mindful_lifting/screens/authenticate/authenticate.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:provider/provider.dart';
import '../../userCalendar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_localizations/flutter_localizations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _auth = new AuthService();




  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    Future getProjects() async {
      final Firestore _firestore = Firestore.instance;
      final currentUserUID = await _auth.getCurrentUserUID();
      QuerySnapshot querySnapshot = await _firestore.collection('users').document(currentUserUID).collection('projects').getDocuments();
      return querySnapshot.documents;
    }

    String getInitial({String string, int limitTo}) {
      var buffer = StringBuffer();
      var split = string.split(' ');
      for (var i = 0 ; i < (limitTo ?? split.length); i ++) {
        buffer.write(split[i][0]);
      }

      return buffer.toString();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 30.0),),
                AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  title: Text('Projects',
                  style: TextStyle(color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.blueGrey,
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => AddProject()));
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.blueGrey,
                      onPressed: () async {
                        Navigator.push(
                          context, new MaterialPageRoute(builder: (context) => Authenticate()));
                    await _auth.signOut();//this will return null tio the Wrapped class and the if statement there will initiate to show Authenticate screen
                    },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: FutureBuilder(
                    future: getProjects(),
                      builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading..."),
                      );
                  }else{
                      return Center(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                            return Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white60),
                                child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right: new BorderSide(width: 1.0, color: Colors.teal))),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.teal,
                                        child: Text(getInitial(string: snapshot.data[index].data["projectName"], limitTo: 1)),
                                      ),
                                    ),
                                    title: Text(snapshot.data[index].data["projectName"],
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                                    trailing:
                                    Icon(Icons.keyboard_arrow_right, color: Colors.teal, size: 30.0),
                                ),
                              ),
                            );
                        }),
                      );
                    }
                  }),
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}