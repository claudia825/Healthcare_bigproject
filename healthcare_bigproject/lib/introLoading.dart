import 'package:flutter/material.dart';
import 'dart:math';

class IntroLoading extends StatefulWidget {
  _IntroLoading _introLoading = _IntroLoading();

  void start() {
    _introLoading.start();
  }

  void stop() {
    _introLoading.stop();
  }

  @override
  State<StatefulWidget> createState() => _introLoading;
}

class _IntroLoading extends State<IntroLoading>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/circle.png',
                width: 100,
                height: 100,
              ),
              Center(
                child: Image.asset(
                  'assets/sunny.png',
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Transform.rotate(
                  angle: _animation!.value,
                  origin: Offset(35, 35),
                  child: Image.asset(
                    'assets/saturn.png',
                    width: 20,
                    height: 20,
                  ),),)
            ],),);
      },);
  }

  void stop() {
    _animationController!.stop(canceled: true);
  }

  void start() {
    _animationController!.repeat();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0, end: pi * 2).animate(_animationController!);
    _animationController!.repeat();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
