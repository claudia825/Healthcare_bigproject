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
                    margin: EdgeInsets.fromLTRB(80, 80, 80, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: TextStyle(fontSize: 18)),
                        TextField(
                          onChanged: (text) {
                            setState(() {
                              inputEmail = text;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(80, 20, 80, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password', style: TextStyle(fontSize: 18)),
                        TextField(
                          obscureText: true,
                          onChanged: (text) {
                            inputPWD = text;
                          },
                        ),
                      ],
                    ),
                  ),
                  // Login ??????!! -> ?????? ???????????? ?????? ???????????? ???????????? ?????? User?????? ???????????? ????????? -> email, password??? ????????? ??? ??????
                  // 221219 -> ?????? ???????????? snackbar?????? ??? ?????? ?????? ?????? ??????, ????????? ?????? ??????(provider ??????), ????????? ???????????? ?????? ?????? ??????????????? ????????????
                  Container(
                    margin: EdgeInsets.fromLTRB(80, 30, 80, 10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff82b3e3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            await auth.signInWithEmailAndPassword(
                                email: inputEmail, password: inputPWD);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(content: Text('Login Success')),
                              );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          } catch (e) {
                            print('login fail: ${e}');
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(content: Text('Login Fail')),
                              );
                          }
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),

                  Container(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => findPassword()));
                            },
                            child: Text('Forgotten Password?')),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (c) => SignUp()));
                            },
                            child: Text('Or Create New Account'))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff82b3e3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {
                              signInWithGoogle();
                            },
                            child: Text('Start with Google',
                                style: TextStyle(fontSize: 15, color: Colors.white)))
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
