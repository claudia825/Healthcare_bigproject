import 'package:flutter/material.dart';

var theme = ThemeData(

  appBarTheme: AppBarTheme(
    color: Colors.white,
    backgroundColor: Color(0xffB3D6FF),
    elevation: 1,
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
  ),

  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Color(0xff94C6FF),
      textStyle: TextStyle(color: Colors.black),
    ),
  ),



  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black54,
  ),

);