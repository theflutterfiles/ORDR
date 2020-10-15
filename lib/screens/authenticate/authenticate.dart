import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/screens/authenticate/register.dart';
import 'package:flutter_app_mindful_lifting/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  //state to show either sign in or register
  bool showSignIn = true;

  //toggle function to change the view
  void toggleView(){
    setState(() => showSignIn = !showSignIn); //if its currently true this statement will make it false
    print(showSignIn.toString());
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView); //pass down the toggle view value defined above
    }else{
      return Register(toggleView: toggleView);
    }
  }
}