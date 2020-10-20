import 'package:flutter/material.dart';

class AppThemeColours {
  static const BoxDecoration BlueGreenGradientBox = BoxDecoration(
    gradient: BlueGreenLinearGradient,
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );

  static const LinearGradient BlueGreenLinearGradient = LinearGradient(
    colors: [
      Color(0xffD5D7F5), //Color(0xFF5ce1e6),
      Color(0xffD5D7F5), //Color(0xFF3cebb6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Color LightPurple = Color(0xffD5D7F5);

  static const BoxDecoration DashboardCardBox = BoxDecoration(
    gradient: DashboardCardGradient,
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );

  static const LinearGradient DashboardCardGradient = LinearGradient(
    colors: [
      Color(0xffB5B8F0),
      Colors.white,
      //Color(0xFF3cebb6),
      //Color(0xFFE1F5E1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color NavigationNotSelectedColor = Color(0xFF3cebb6);

  static const Color NavigationSelectedColor = GreenHighlight;

  static const Color NavigationBarColor = Color(0xFF131622);

  static const Color NavigationBarIconColor = Colors.white;

  static const Color NavigationAvatarColor = Colors.white;

  //static const Color NavigationSelectedBackgroundColor = Color(0xFF58968B);

  //static const Color DashboardColor = Colors.white;

  static const Color DashboardWhite = Color(0xFFF3F7FB);

  static const Color GreenHighlight = Color(0xFF37C39C);

  static const Color OrangeColour = Color(0xFFE8740C);

  static const Color Purple = Color(0xFF4E3EC8);

  static const Color DoneGreen = Color(0xFF00A57B);

  static const Color Yellow = Color(0xFFFDCA40);

  static const List<Color> DashboardCardColors = [
    Color(0xFFC4D5F0),
    Color(0xFFB8B5F8),
    Color(0xFFE3BFDB),
    Color(0xFFB5A8EE),
    Color(0xFFC1E2DB),
    Color(0xFF58968B),
  ];

  static const LinearGradient dashboardCardGradient = LinearGradient(
    colors: [
      Colors.white, //GreenHighlight,
      Colors.white,
      //Color(0xFF58968B),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const TextFieldLineColor = Color(0xFF333333);
}
