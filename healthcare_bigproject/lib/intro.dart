import 'package:flutter/material.dart';
import 'package:healthcare_bigproject/introLoading.dart';
import 'dart:async';
import 'main.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Viet Doc', style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 20,
              ),
              IntroLoading()
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),),),);
  }
}
