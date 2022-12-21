import 'package:flutter/material.dart';
import './drawer.dart';
import './waitlist.dart';
import './maps.dart';
import './maps2.dart';
import './signup.dart';
import './login.dart';
import 'package:flutter/cupertino.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/cupertino.dart'; // cupertino 스타일 가져다쓰기 위함
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider;
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './m2e.dart';
import './qr_scanner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          child: const MaterialApp(home: MyApp(), )));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var qrResult;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {

    // 예약 DB 구축후 수정
    final pages = List.generate(
        6,
            (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade300,
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Container(
            height: 280,
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
      appBar: AppBar(
        // leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: Text('Viet Doc'),
        actions: [
          IconButton(onPressed: (){
            _onPressedFAB();
          }, icon: Icon(Icons.qr_code_2)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined)),
        ],

      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          margin: EdgeInsets.all(10),
          child: Column(children: [
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: controller,
                // itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            Container(
              child: PageIndicator(pages:pages, controller:controller),
            ),
            Container(child: TextButton(child: Text('M2E', style: TextStyle(color: Colors.white),), onPressed: (){
              if(auth.currentUser != null) {
                Navigator.push(context, MaterialPageRoute(builder: (c) => M2E()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
              }
            },), color: Colors.blue, width: 300, height: 100, margin: EdgeInsets.all(10),),
            Container(child: TextButton(child: Text('+ 인근 병원 대기 확인', style: TextStyle(color: Colors.white),), onPressed: (){
              if(auth.currentUser != null) {
                Navigator.push(context, MaterialPageRoute(builder: (c) => CurrentLocationScreen()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
              }
            },), color: Colors.blue, width: 300, height: 100, margin: EdgeInsets.all(10),),
          ],),
        ),
      ),
      drawer: MainDrawer(),
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



