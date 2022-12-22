import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_bigproject/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    print('splash init!!!!');
    Timer(
      Duration(seconds: 1),
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xff82b3e3),
        image: DecorationImage(
            image: AssetImage('assets/logoWhite.png'), fit: BoxFit.contain),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width -100,
              height: height -100,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}