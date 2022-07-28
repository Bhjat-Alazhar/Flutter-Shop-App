import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(

  inputDecorationTheme: InputDecorationTheme(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white ,width: 1.5)),labelStyle: TextStyle(color: Colors.white),prefixStyle: TextStyle(color: Colors.white) ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(

    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    actionsIconTheme: IconThemeData(color: Colors.white),
    backgroundColor: HexColor('333739'),
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.white),

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0),
  textTheme: TextTheme(
    subtitle1: TextStyle(color: Colors.white,fontSize: 18),
      bodyText1: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
    bodyText2: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
  ),
  fontFamily: 'Jannah',
  iconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white,

);
ThemeData lightTheme = ThemeData(
  inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(color: Colors.black),prefixStyle: TextStyle(color: Colors.black) ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      backgroundColor: Colors.white,
      elevation: 20.0),
  textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.black,fontSize: 18),
      bodyText1: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w800, color: Colors.black),
    bodyText2: TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
  ),

  fontFamily: 'Jannah',
  iconTheme: IconThemeData(color: Colors.black),

);
