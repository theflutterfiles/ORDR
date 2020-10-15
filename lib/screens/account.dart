import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/screens/authenticate/authenticate.dart';
import 'authenticate/authenticate.dart';

class Account extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return Container(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                child: RaisedButton(
                  child: Text("Sign out"),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) =>
                            Authenticate())
                    );
                    //await _auth.signOut();//this will return null tio the Wrapped class and the if statement there will initiate to show Authenticate screen
                  },
                ),
              ),
            ),
          ],
        ),
      );
  }
}
