import 'package:flutter/material.dart';

var theme = ThemeData(

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff82b3e3),
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  ),

  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(color: Colors.black),
    ),
  ),



  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black54,
  ),

);