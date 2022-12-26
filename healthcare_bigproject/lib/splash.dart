import 'dart:async';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_bigproject/main.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  var dummy = 0;
  @override
  void initState() {
    super.initState();
    print('splash init!!!!');
    setState(() {
      dummy += 1;
      Timer(
        Duration(seconds: 2),
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        ),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WidgetAnimator(
      //1
        // incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
        //     curve: Curves.bounceOut,
        //     duration: const Duration(milliseconds: 1500)),
        // atRestEffect: WidgetRestingEffects.dangle(),
        // outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
      //2
        // incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
        //     curve: Curves.bounceOut,
        //     duration: const Duration(milliseconds: 1500)),
        // atRestEffect: WidgetRestingEffects.dangle(),
        // outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
      //3
        atRestEffect: WidgetRestingEffects.pulse(effectStrength: 1),
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(
            blur: const Offset(0, 20), scale: 3),
      //
      child: Container(
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
      )
    );
  }
}






// Animate(
// effects: [FadeEffect(), ScaleEffect()],
// child: Text("Hello World!"),
// )


// class SplashScreen extends StatefulWidget {
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
//   //Your animation controller
//   AnimationController _controller;
//   Animation _animation;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );
//     //Implement animation here
//     _animation = Tween(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(_controller);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _controller.forward();
//     return GestureDetector(
//       onTap: (){
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MyApp()),
//         );
//       },
//       child: Container(
//         color: Colors.pink,
//         child: Center(
//             child: Hero(
//               tag: "heroLogo",
//               //FadeTransition makes your image Fade
//               child: FadeTransition(
//                 //Use your animation here
//                 opacity: _animation,
//                 child: CircleAvatar(
//                   //Here you load you image
//                   backgroundImage: AssetImage("assets_image.png"),
//                   radius: MediaQuery.of(context).size.width * 0.25,
//                 ),
//               ),
//             )
//         ),
//       ),
//     );
//   }
// }