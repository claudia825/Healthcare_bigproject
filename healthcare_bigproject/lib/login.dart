import 'package:flutter/material.dart';
import './signup1.dart' as signup1;
import './signup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new),),
        title: Text('Log In'),),
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(80, 80, 80, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID', style: TextStyle(fontSize: 18)),
                  TextField(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(80, 20, 80, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Password', style: TextStyle(fontSize: 18)),
                  TextField(),
          ],
        ),
      ),
            TextButton(onPressed: (){},
                child: const Text('Log In', style: TextStyle(fontSize: 30),)),

            Container(
              child: Column(
                children: [
                  TextButton(onPressed: (){}, child: Text('Forgotten Password?')),
                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (c) => SignUp()));}, child: Text('Or Create New Account'))
                ],
              ),
            ),
            Container(

              child: Column(
                children: [
                  TextButton(onPressed: (){}, child: Text('Start with Facebook',style: TextStyle(fontSize: 20))),
                  TextButton(onPressed: (){}, child: Text('Start with Google',style: TextStyle(fontSize: 20)))
                ],
              ),
            ),
    ]
        ),
          )
          );
  }
}
