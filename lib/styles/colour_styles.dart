import 'package:flutter/material.dart';

class AppThemeColours {
  static const BoxDecoration BlueGreenGradientBox = BoxDecoration(
    gradient: BlueGreenLinearGradient,
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );

  static const LinearGradient BlueGreenLinearGradient =
    LinearGradient(
      colors: [
        Color(0xFF5ce1e6),
        Color(0xFF3cebb6),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );
}
