import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './signup.dart';
import './main.dart';
import './auth.dart';
import './register.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;


class Signup1 extends StatelessWidget {
  Signup1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_new),),
          title: Text('Sign Up'),),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          child: Column(
            children:[
              EmailInput(),
              PasswordInput(),
              PasswordConfirmInput(),
              hpInput(),
              Container(
                margin: EdgeInsets.fromLTRB(20,50,20,20),
                  child: RegistButton()
              ),

              ]
          ),
        ),
      ),
    );
  }
}



class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(80, 100, 80, 0),
      child: TextField(
        onChanged: (email) {
          register.setEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(fontSize: 20),
          //helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(80, 10, 80, 0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(fontSize: 20),
        ),
        onChanged: (password) {
          // This optional block of code can be used to run
          // code when the user saves the form.
          register.password = password;
        },
      ),
    );
  }
}

class PasswordConfirmInput extends StatelessWidget {
  var _name;

  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(80, 10, 80, 0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password Confirm',
          labelStyle: TextStyle(fontSize: 20),
        ),
        onChanged: (password) {
          // This optional block of code can be used to run
          // code when the user saves the form.
          register.passwordConfirm = password;
        },
        validator: (String? value) {
          return (value != register.password) ? 'Password does not match.' : null;
        },
      ),
    );
  }
}



class hpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(80, 10, 80, 0),
      child: TextField(
        onChanged: (hp) {
          register.setHp(hp);
        },
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'H.P.',
          labelStyle: TextStyle(fontSize: 20),
          //helperText: '',
        ),
      ),
    );
  }
}


class RegistButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);
    final register = Provider.of<RegisterModel>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(80, 10, 80, 0),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.08,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff82b3e3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: ((register.password != register.passwordConfirm) || (register.password == null)) ? null : () async {
          var user = await authClient
              .registerWithEmail(register.email, register.password)
              .then((registerStatus) {
            if (registerStatus == AuthStatus.registerSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Regist Success')),
                  // 전화번호/ UID 별도로 DB에 넣기
                  // firestore collection 만들고 규칙 정하기
                );
              print(auth.currentUser?.uid);
              print(register.hp.toString());
              //홈으로 pop
              Navigator.popUntil(context, ModalRoute.withName("/"));
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Regist Fail')),
                );
            }
          });
        },
        child: Text('Sign Up', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}