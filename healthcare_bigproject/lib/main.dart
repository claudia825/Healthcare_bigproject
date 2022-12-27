import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_bigproject/splash.dart';
import './drawer.dart';
import './waitlist.dart';
import './maps.dart';
import './maps2.dart';
// import './signup.dart';
// import './login.dart';
import 'package:flutter/cupertino.dart';
import './style.dart' as style;
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import './carousel.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/cupertino.dart'; // cupertino 스타일 가져다쓰기 위함
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider;
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './m2e.dart';
import './qr_scanner.dart';
import './search_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:searchbar_animation/searchbar_animation.dart';
//import 'package:neuomorphic_container/neuomorphic_container.dart';

final auth = FirebaseAuth.instance;
final firebase = FirebaseFirestore.instance;

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e);
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
      ],
      child: MaterialApp(
        theme: style.theme,

        home: SplashScreen(),
      )));

}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var uid;
  var data;
  var infoList = [];
  var pages = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  getLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      print('**************Permission Granted');
    } else {
      print('**************Permission Denied');
      await Permission.location.request();
    }
  }

  getCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      print('**************Permission Granted');
    } else {
      print('**************Permission Denied');
      await Permission.camera.request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAuthInfo();
  }

  // 예약 DB 구축후 수정
  getAuthInfo() async {
    try {
      if (auth.currentUser != null) {
        uid = auth.currentUser?.uid;
        data =
            await firebase.collection('reservation').doc(uid.toString()).get();
        print(data['info']);

        for (var i = 0; i < data['info'].length; i++) {
          var doctors = await firebase
              .collection('hospital')
              .doc(data['info'][i]['hospital'].toString())
              .get();
          var order = doctors['doctor'][data['info'][i]['doctor']]['waitList']
              .indexOf(uid.toString());
          infoList.add({
            'hospital': data['info'][i]['hospital'],
            'doctor': data['info'][i]['doctor'],
            'order': order
          });
        }
      }
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!infoList: ${infoList}');

      setState(() {
        if (infoList.length != 0) {
          pages = List.generate(
              infoList.length,
              (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade300,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Container(
                        height: 300,
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Hospital: ${infoList[index]['hospital']}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Doctor: ${infoList[index]['doctor']}',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'There are ${infoList[index]['order'].toString()} people waiting in front of you.',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )),
                  ));
        }
      });
    } catch (error) {
      print('error!');
    }
  }

  var qrResult;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final dummyPage = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
          height: 300,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('There is no reservation.'),
              ],
            ),
          )),
    );
    // print('pages.length: ${pages.length}');

    // QR 코드 찍고 난뒤 정보 받는 부분
    void _onPressedFAB() async {
      //비동기 실행으로 QR화면이 닫히기 전까지 await으로 기다리도록 한다.
      dynamic result =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return QRCheckScreen(eventKeyword: 'userId');
      }));

      if (result != null) {
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
          IconButton(
              onPressed: () {
                getCameraPermission();
                _onPressedFAB();
              },
              icon: Icon(Icons.qr_code_2)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getAuthInfo();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(children: [carousel(), Positioned(child: searchBar())]),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Wait List',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Stack(
                        children: [
                          waitListBox(
                              pages: pages,
                              controller: controller,
                              dummyPage: dummyPage),
                          Positioned(
                            top: 100,
                            left: 225,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => Reservations()));
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff82b3e3)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  //side: BorderSide(color: Colors.red) // border line color
                                )),
                              ),
                              child: Row(children: [
                                Icon(Icons.add),
                                Text('Reservations'),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity, height: 100,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Color(0xa8cce2f8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //color: Color(0xff94C6FF), width: 300, height: 200, margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Text(
                            'M2E',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) => M2E()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity, height: 100,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Color(0xa8cce2f8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //color: Color(0xff94C6FF), width: 300, height: 200, margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Text(
                            'Hospitals Near Me',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => CurrentLocationScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key, this.n_pages, this.controller})
      : super(key: key);
  final n_pages;
  final controller;
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
        controller: controller,
        count: n_pages == 0 ? 1 : n_pages,
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

class waitListBox extends StatelessWidget {
  const waitListBox({Key? key, this.pages, this.controller, this.dummyPage})
      : super(key: key);
  final pages;
  final controller;
  final dummyPage;

  @override
  Widget build(BuildContext context) {
    if (pages.length != 0) {
      return SizedBox(
        height: 150,
        width: double.infinity,
        child: PageView.builder(
          controller: controller,
          // itemCount: pages.length,
          itemBuilder: (_, index) {
            return pages[index % pages.length];
          },
        ),
      );
    } else {
      return SizedBox(
        height: 150,
        width: double.infinity,
        child: PageView.builder(
          controller: controller,
          // itemCount: pages.length,
          itemBuilder: (_, index) {
            return dummyPage;
          },
        ),
      );
    }
  }
}
