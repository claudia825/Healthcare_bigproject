import 'package:flutter/material.dart';

var theme = ThemeData(

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff82b3e3),
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
  ),

  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(color: Colors.black),
    ),
  ),


);