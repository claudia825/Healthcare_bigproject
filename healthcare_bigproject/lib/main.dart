import 'package:flutter/material.dart';
import 'package:healthcare_bigproject/searchbar.dart';
import 'package:healthcare_bigproject/splash.dart';
import 'package:healthcare_bigproject/waitlist.dart';
import './drawer.dart';
import './maps2.dart';
import './login.dart';
// import 'package:flutter/cupertino.dart'; // cupertino 스타일 가져다쓰기 위함
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider;
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';
import 'carousel.dart';
import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';
import './m2e.dart';
import './qr_scanner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import './style.dart' as style;
import './intro.dart';
import 'light_color.dart';
import 'm2e.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

final auth = FirebaseAuth.instance;


void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  } catch (e) {
    print(e);
  }

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
          ],
          child: MaterialApp(
            theme: style.theme,
            home: Splash(),
            //theme: style.theme,
          )));
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var qrResult;
  final controller = PageController(viewportFraction: 1.0, keepPage: true);
  TextEditingController textController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    // 예약 DB 구축후 수정
    final pages = List.generate(6,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
              height: 280, width: double.infinity,
                child: Center(
                    child: Text(
                      "Page $index",
                      style: TextStyle(color: Colors.indigo),
                    )),
            ),
            ));


    // QR 코드 찍고 난뒤 정보 받는 부분
    void _onPressedFAB() async { //비동기 실행으로 QR화면이 닫히기 전까지 await으로 기다리도록 한다.
      dynamic result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return QRCheckScreen(eventKeyword: 'userId');
      }));

      if(result != null) {
        setState(() {
          //qr스캐너에서 받은 결과값을 화면의 qrResult 에 적용하도록 한다.
          qrResult = result.toString();
        });
      }
    }

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(

        // leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          },
          child: Image.asset(
            'assets/logoWhite.png',
            fit: BoxFit.scaleDown,
            height: 90,
            width: 120,
          ),
        ),
        backgroundColor: Color(0xff82b3e3),
        actions: [
          IconButton(onPressed: (){
            _onPressedFAB();
          }, icon: Icon(Icons.qr_code_2)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined)),
        ],

      ),

      body: SingleChildScrollView(
        child: Column(
            children: [
            Stack(
            children :[
              carousel(),
            Positioned(child: searchBar())
        ]
        ),

        Container(
          margin: EdgeInsets.fromLTRB(10,20,10,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('  Wait List', style: TextStyle(fontFamily: 'VarelaRound', color: Colors.black, fontSize: 20),),
              Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: controller,
                      // itemCount: pages.length,
                      itemBuilder: (_, index) {
                        return pages[index % pages.length];
                      },
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 225,
                    child:
                    ElevatedButton(
                      onPressed: () {Navigator.push(context,
                          MaterialPageRoute(builder: (c) => Reservations())
                      );},
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff82b3e3)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              //side: BorderSide(color: Colors.red) // border line color
                            )),
                      ),
                      child: 
                       Row(children : [Icon(Icons.add), Text('Reservations'),]),
                    ),
                  )
                ],
              ),
              ] ),),


              Column(
                children: [

                  Container(
                    width: double.infinity, height: 100,
                    margin: EdgeInsets.fromLTRB(20,10,20,10),
                    decoration: BoxDecoration(
                      color: Color(0xa8cce2f8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //color: Color(0xff94C6FF), width: 300, height: 200, margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Text('M2E', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) => M2E())
                            );
                          },),
                      ],
                    ),),
                  Container(
                    width: double.infinity, height: 100,
                    margin: EdgeInsets.fromLTRB(20,10,20,10),
                    decoration: BoxDecoration(
                      color: Color(0xa8cce2f8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //color: Color(0xff94C6FF), width: 300, height: 200, margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Text('Hospitals Near Me',style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) => CurrentLocationScreen())
                            );
                          },),
                      ],
                    ),),
                ],
              ),
          ],),
        ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key, this.pages, this.controller}) : super(key: key);
  final pages;
  final controller;
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
        controller: controller,
        count: pages.length,
        effect: ScrollingDotsEffect(
          activeStrokeWidth: 2.6,
          activeDotScale: 1.3,
          maxVisibleDots: 5,
          radius: 8,
          spacing: 10,
          dotHeight: 12,
          dotWidth: 12,
        ));
  }
}



