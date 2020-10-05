import 'package:cloud_firestore/cloud_firestore.dart';

class Account {

  //info
   String displayName;
   String email;
   
  Account(this.displayName, this.email,);

  Account.fromMap(Map<String, dynamic> data){
    displayName = data['displayName'];
    email = data['email'];
  }

  String convertToString(){
    return "displayname: " + this.displayName + "\n"
        + "email: " + this.email + "\n";
  }

  Map<String, dynamic> toJson() => {
    'displayName' : displayName,
    'email' : email,
  };

// creating a Trip object from a firebase snapshot
  Account.fromSnapshot(DocumentSnapshot snapshot) :
    displayName = snapshot['displayName'],
    email = snapshot['email'];
}