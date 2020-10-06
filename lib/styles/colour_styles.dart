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
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    static const BoxDecoration DashboardCardBox = BoxDecoration(
    gradient: DashboardCardGradient,
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );

  static const LinearGradient DashboardCardGradient =
    LinearGradient(
      colors: [
        Color(0xFF3cebb6),
        Color(0xFFE1F5E1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    static const Color NavigationNotSelectedColor = Color(0xFF3cebb6);

    static const Color NavigationSelectedColor = Colors.white;

    static const Color NavigationBarColor = Color(0xFF242544);

    static const Color NavigationBarIconColor = Colors.white;

    static const Color NavigationAvatarColor = Colors.white;

    static const Color NavigationSelectedBackgroundColor = Color(0xFFEBEBEB);

    static const Color DashboardColor = Colors.white;

    static const Color DarkPurple = Color(0xFF242544);

    static const Color GreenHighlight = Color(0xFF6ADA00);

    static const Color OrangeColour = Color(0xFFE8740C);

    static const List<Color> DashboardCardColors = [

      Color(0xFFC4D5F0),
      Color(0xFFB8B5F8),
      Color(0xFFE3BFDB),
      Color(0xFFB5A8EE),
      Color(0xFFC1E2DB),
    
    ];

}
