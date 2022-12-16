import 'package:flutter/material.dart';
import './signup.dart';
import './main.dart';

class Signup1 extends StatelessWidget {
  const Signup1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new),),
        title: Text('Sign Up'),),
      body: Column(
        children:[
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(80, 80, 80, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID or E-mail', style: TextStyle(fontSize: 18)),
                        TextField(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(80, 20, 80, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password', style: TextStyle(fontSize: 18)),
                        TextField(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(80, 20, 80, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password Confirm', style: TextStyle(fontSize: 18)),
                        TextField(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(80, 20, 80, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('H.P.', style: TextStyle(fontSize: 18)),
                        TextField(),
                      ],
                    ),
                  ),
                ]
            ),
          ),
          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (c) => MyApp()));}, child: Text('Confirm', style: TextStyle(fontSize: 20),))
        ]
      ),
    );
  }
}
