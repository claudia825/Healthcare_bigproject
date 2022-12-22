import 'package:flutter/material.dart';
var theme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff82b3e3),
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
        fontFamily: 'VarelaRound',color: Colors.white,
        fontWeight: FontWeight.bold, fontSize: 25),
  ),

  textTheme: TextTheme(
    bodyText2: TextStyle(
        fontFamily: 'VarelaRound',
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 20),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(fontFamily: 'VarelaRound', color: Colors.black),
    ),
  ),

);