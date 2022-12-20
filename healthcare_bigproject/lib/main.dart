import 'package:flutter/material.dart';
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
import 'firebase_options.dart';
import './intro.dart';

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
          child: MaterialApp(home: IntroPage(), )));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        title: Text('Viet Doc'),
        backgroundColor: Color(0xff498acc),
        centerTitle: true,
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined))],

      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.black,
          margin: EdgeInsets.fromLTRB(20,80,20,20),
          child: Column(
            children: [
            Container(
              width: 330, height: 200,
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
                      Navigator.push(context, MaterialPageRoute(builder: (c) => SignUp()));
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
      drawer: MainDrawer(),
    );
  }
}
