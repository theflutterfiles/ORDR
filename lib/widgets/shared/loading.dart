import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff4BB9AA),
            Color(0xff208294),
            Color(0xff0E5187),
            Color(0xff0E2352),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
      child: Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}