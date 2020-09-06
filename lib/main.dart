import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/screens/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //wrap wrapper in provider
    return StreamProvider<User>.value(
      //what value we expect to get back from the Stream provider
      value: AuthService().user, //accessing the user defined in the Stream function in Stream<User> get <user>
      //we are now listening to this stream provider inside this widget using the stream (value)
      child: MaterialApp(
        //the widgets inside here can access the values provided by stream provider value above e.g. user data from Stream<User> get user
        home: Wrapper(
        ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
          const Locale('en', ''),
          //const Locale('aus', ''),
      ],
        ),

    );
  }
}

