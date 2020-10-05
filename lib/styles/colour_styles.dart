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

    static const Color NavigationSelectedColor = Color(0xFF3cebb6);



    static const Color NavigationAvatarColor = Color(0xFFFFeb3b);

    static const Color NavigationSelectedBackgroundColor = Color(0xFFEBEBEB);

}
