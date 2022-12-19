import 'package:flutter/material.dart';
import './signup1.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {

  var _isChecked = [false, false, false, false];

  changeChecked(id){
    if (id == 3) {

      if (_isChecked[id] == false) {
        setState(() {
          for( var i = 0; i < 4; i ++) {
            _isChecked[i] = true;
          }
        });
      } else {
        setState(() {
          for( var i = 0; i < 4; i ++) {
            _isChecked[i] = false;
          }
      });
      }
    } else {
      setState(() {
        if (_isChecked[id] == false) {
          _isChecked[id] = true;
        } else {
          _isChecked[id] = false;
        }
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
          title: Text('회원가입'),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined))],
        ),
        body: Container(padding:EdgeInsets.all(30), color:Color.fromRGBO(
            210, 210, 210, 1.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex:1,child:Text('Privacy Policy')),
          Expanded(
            flex:3,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text( "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " +
                  "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " +
                  "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" +
                  "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" +
                  "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " +
                  "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" +
                  "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" +
                  "8 Description that is too long in text format(Here Data is coming from API)" +
                  "9 Description that is too long in text format(Here Data is coming from API)" +
                  "10 Description that is too long in text format(Here Data is coming from API)",style: TextStyle(
                  fontSize: 16.0, color: Colors.white))
            ),
          ),
          CheckBox(isChecked: _isChecked, changeChecked:changeChecked, id:0, content:'Agree'),
          Expanded(flex:1,child:Text('Terms of Use')),
          Expanded(
            flex:3,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text( "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " +
                    "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " +
                    "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" +
                    "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" +
                    "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " +
                    "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" +
                    "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" +
                    "8 Description that is too long in text format(Here Data is coming from API)" +
                    "9 Description that is too long in text format(Here Data is coming from API)" +
                    "10 Description that is too long in text format(Here Data is coming from API)",style: TextStyle(
                    fontSize: 16.0, color: Colors.white))
            ),
          ),
          CheckBox(isChecked: _isChecked,changeChecked:changeChecked, id:1, content:'Agree'),
          CheckBox(isChecked: _isChecked,changeChecked:changeChecked, id:2, content:'Adult'),
          CheckBox(isChecked: _isChecked,changeChecked:changeChecked, id:3, content:'Agree all'),
          TextButton(onPressed: ((_isChecked[0] == true) && (_isChecked[1] == true) && (_isChecked[2] == true)) ? (){
            Navigator.push(context, MaterialPageRoute(builder: (c) => Signup1() ));
          } : null, child: Text('Next'))
        ],
          
        )
        ),

    );
  }
}

class CheckBox extends StatefulWidget {
  CheckBox({Key? key, this.isChecked, this.content, this.changeChecked, this.id}) : super(key: key);
  var isChecked;
  var content;
  var changeChecked;
  var id;
  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    if((widget.isChecked[0] == true) && (widget.isChecked[1] == true) && (widget.isChecked[2] == true)) {
      widget.isChecked[3] = true;
    } else {
      widget.isChecked[3] = false;
    }
    return Expanded(flex:1,child:
    Row(children: [Checkbox(
        value: widget.isChecked[widget.id],
        onChanged: (value) {
          widget.changeChecked(widget.id);
        }
    ), Text(widget.content)]
    )
    );
  }
}
