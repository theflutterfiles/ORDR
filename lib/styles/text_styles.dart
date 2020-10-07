import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {


  //GoogleFonts.workSans(textStyle: AppThemes.listText, fontSize: 20);
 
  static const TextStyle display1 = TextStyle(
    fontSize: 38,
    color: Color(0xFF333333),
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
  );

  static const TextStyle display2 = TextStyle(
    fontSize: 32,
    fontFamily: 'WorkSans',
    color: Color(0xFF333333),
    fontWeight: FontWeight.normal,
    letterSpacing: 1.1,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 34,
    fontFamily: 'WorkSans',
    color: Color(0xFF333333),
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );

  static const TextStyle listText = TextStyle(
    fontSize: 14,
    color: Color(0xFF333333),
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
  );

  static const TextStyle navigationListText = TextStyle(
    fontSize: 20,
    color: Color(0xFFEBEBEB),
    fontWeight: FontWeight.w500,
    letterSpacing: 1.2,
  );

  static const TextStyle navigationListTextSelected = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static const TextStyle avatarListText = TextStyle(
    fontSize: 20,
    //fontFamily: 'WorkSans',
    color: AppThemeColours.NavigationBarIconColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static const TextStyle DashboardCardContentText = TextStyle(
    fontSize: 35,
    //fontFamily: 'WorkSans',
    color: AppThemeColours.DashboardWhite,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );
  static const TextStyle DashboardCardTitleText = TextStyle(
    fontSize: 20,
    //fontFamily: 'WorkSans',
    color: AppThemeColours.NavigationBarColor,
    //fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );
  static const TextStyle DashboardProgressText = TextStyle(
    fontSize: 20,
    //fontFamily: 'WorkSans',
    color: AppThemeColours.NavigationBarColor,
    //fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );
  static const TextStyle DashboardCardBudgetNumber = TextStyle(
    fontSize: 20,
    //fontFamily: 'WorkSans',
    color: AppThemeColours.DashboardWhite,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static const TextStyle DateSubtitle = TextStyle(
    fontSize: 15,
    fontFamily: 'WorkSans',
    color: AppThemeColours.NavigationBarColor,
    fontStyle: FontStyle.italic,
    letterSpacing: 1.2,
  );
}
