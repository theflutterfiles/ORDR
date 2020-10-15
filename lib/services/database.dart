
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  //collection reference
  final Firestore _firestore = Firestore.instance;  
  
  // Stream<User> streamUser (String id){
  //   return _firestore
  //   .collection('users')
  //   .document(id)
  //   .snapshots()
  //   .map((snap) => User.fromMap(snap.data));
  // }

  Stream<List<Project>> streamProjects(String uid)   {

    var ref = _firestore.collection("users")
    .document(uid).collection("projects");

    return ref.snapshots()
    .map((list) => list.documents
    .map((doc) => Project.fromSnapshot(doc))
    .toList());
  }

 








}