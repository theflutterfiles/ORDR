import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectDetailPage extends StatefulWidget {
  final QuerySnapshot document;

  ProjectDetailPage({this.document});

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.document.toString()),
    );
  }
}
