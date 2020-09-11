import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';

  class AuthService{

    //private final var to get Firebase Auth instance
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final Firestore _firestore = Firestore.instance;

   //create custom user object based on firebase user
   User _userFromFirebaseUser(FirebaseUser user){
     return user != null ? User(uid: user.uid, displayName: user.displayName) : null;
   }

   //auth change user stream
   Stream<User> get user{
     //map firebase user to customer user class
     //every time user sings in or out we will get a response down the stream null if signed out or user object if signed in
     return _auth.onAuthStateChanged
         //.map((FirebaseUser user) => _userFromFirebaseUser(user));
     .map(_userFromFirebaseUser);
   }

    //sign in anon - asynchronous task returns Future
  Future signInAnon() async {
    try{
      //try sign in anonymously - knows which backend via google service.json
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user; //gains us access to the user object
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

    //sign in email and password
   Future signInWitEmailAndPassword(String email, String password) async {
     try{
       AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password); //get response from the function
       FirebaseUser user = authResult.user; //store the result in firebase user object
       return _userFromFirebaseUser(user); //convert to custom user with uid
     }catch(e){
       print(e.toString());
       return null;
     }
   }

    //register with email and password
   Future registerWitEmailAndPassword(String email, String password, String displayName) async {
     try{
       AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password); //get response from the function
       FirebaseUser user = authResult.user; //store the result in firebase user object
       String currentUserUid = user.uid;
       _firestore.collection('users').document(currentUserUid).collection('about').add({'email': email, 'displayName': displayName});
       return _userFromFirebaseUser(user); //convert to custom user with uid
     }catch(e){
       print(e.toString());
       return null;
     }
   }

    //sign out
  Future<void> signOut() async {
     try{
       return await _auth.signOut(); //built into FireBaseAuth library
     }catch(e){
       print(e.toString());
       return null;
     }
  }

  Future<String> getCurrentUserUID() async{
     return (await _auth.currentUser()).uid;
     //to use in other places = final uid = await Provider.of(context).auth.getCurrentUID();
  }

  }