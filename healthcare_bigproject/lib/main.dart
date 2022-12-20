import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_bigproject/searchbar.dart';
import 'package:healthcare_bigproject/text_styles.dart';
import './drawer.dart';
import './waitlist.dart';
import './maps.dart';
import './maps2.dart';
import './signup.dart';
import './login.dart';
// import 'package:flutter/cupertino.dart';
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
import 'carousel.dart';
import 'firebase_options.dart';
import './intro.dart';
import 'light_color.dart';
import 'move2earn.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

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
          child: MaterialApp(home: MyApp(), )));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        //leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: Text('Viet Doctor'),
        backgroundColor: Color(0xff8bb9ee),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined))],

      ),

      body: SingleChildScrollView(
        child: Container(
          //color: Colors.black,
          //margin: EdgeInsets.fromLTRB(20,20,20,20),

          child: Column(
            children: [
              Stack(
                children :[
                  Carousel(),
                  Positioned(child: searchBar())
                ]
              ),
              Container(
                width: 330, height: 200,
                margin: EdgeInsets.fromLTRB(20,20,20,20),
                decoration: BoxDecoration(
                  color: Color(0xff94C6FF),
                  borderRadius: BorderRadius.circular(30),
                ),
                //color: Color(0xff94C6FF), width: 300, height: 200, margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WaitList(),
                    TextButton(
                      child: Text('예약 현황 확인하기', style: TextStyle(color: Colors.black),),
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => Reservations())
                        );
                      },),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150, height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xff94C6FF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.fromLTRB(10,30,10,10),
                    child: TextButton(child: Text('M2E', style: TextStyle(color: Colors.black),),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c) => M2E()));
                      },),),

                  Container(
                    width: 150 , height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xff94C6FF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.fromLTRB(10,30,10,10),
                    child: TextButton(child: Text('+ 인근 병원 대기 확인', style: TextStyle(color: Colors.black),), onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c) => CurrentLocationScreen()));
                    },),),
              ],
            )
          ],),
        ),
      ),
    );
  }
}
