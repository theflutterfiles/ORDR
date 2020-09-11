import 'package:cloud_firestore/cloud_firestore.dart';

class Project {

  final String projectName;
  final String description;
  final String mission;
  final List<String> goals;

  final Firestore _firestore = Firestore.instance;

  Project({this.projectName, this.description, this.mission, this.goals});
}