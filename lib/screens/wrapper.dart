
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/screens/authenticate/authenticate.dart';
import 'package:flutter_app_mindful_lifting/models/user.dart';
import 'package:provider/provider.dart';
import 'home/homeScreen.dart';

class Wrapper extends StatelessWidget {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {


    final user = Provider.of<User>(context); //access user data from provider the type of data is User as specified in MyApp build method e.g. StreamProvider<User>
    //print(user.uid);

    if(user == null){
      //print("user signed out: " +  " - " + user.uid);
      return new Authenticate();
    }else{
      print("user signed in: " + user.uid);
      return HomePage();
    }
  }
}
