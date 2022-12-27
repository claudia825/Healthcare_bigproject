import 'package:flutter/material.dart';
import './signup1.dart' as signup1;
import './signup.dart';
import './find_password.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './main.dart';
import './drawer.dart';

final auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var inputEmail;

  var inputPWD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log In')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(80, 80, 80, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email', style: TextStyle(fontSize: 18)),
                    TextField(onChanged: (text){
                      setState(() {
                        inputEmail = text;
                      });
                    },),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(80, 20, 80, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password', style: TextStyle(fontSize: 18)),
                    TextField(obscureText: true, onChanged: (text){
                      inputPWD = text;
                    },),
            ],
          ),
        ),
              // Login 버튼!! -> 같은 이메일로 구글 로그인을 시도했을 때는 User에서 자동으로 연동됨 -> email, password로 접속할 수 없음
              // 221219 -> 구글 로그인시 snackbar구성 및 화면 이동 구현 필요, 로그인 상태 유지(provider 이용), 로그인 로그아웃 상태 모든 페이지에서 알게하기
              TextButton(onPressed: () async{
                try {
                  print(inputEmail);
                  print(inputPWD);
                  await auth.signInWithEmailAndPassword(email: inputEmail, password: inputPWD);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('Login Success')),);
                  Navigator.popUntil(context, ModalRoute.withName("/"));
                } catch (e){
                  print('login fail: ${e}');
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('Login Fail')),);
                }
              },
                  child: const Text('Log In', style: TextStyle(fontSize: 30),)),

              Container(
                child: Column(
                  children: [
                    TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (c) => findPassword()));}, child: Text('Forgotten Password?')),
                    TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (c) => SignUp()));}, child: Text('Or Create New Account'))
                  ],
                ),
              ),
              Container(

                child: Column(
                  children: [
                    TextButton(onPressed: (){}, child: Text('Start with Facebook',style: TextStyle(fontSize: 20))),
                    TextButton(onPressed: (){signInWithGoogle();}, child: Text('Start with Google',style: TextStyle(fontSize: 20)))
                  ],
                ),
              ),
    ]
          ),
            ),
      )
          );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}