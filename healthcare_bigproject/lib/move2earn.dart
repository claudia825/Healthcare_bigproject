import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './drawer.dart';


class M2E extends StatefulWidget {
  const M2E({Key? key}) : super(key: key);

  @override
  State<M2E> createState() => _M2EState();
}

class _M2EState extends State<M2E> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('SuperWalk'),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined))],
      ),
      body: Scaffold(
        appBar: AppBar(
          title: Text('대시보드', style: TextStyle(color: Colors.black, fontSize: 18), textAlign: TextAlign.center,),
          backgroundColor: Colors.white70,
          elevation: 0,
          leading: BackButton(color: Colors.blue),
        ),
       body: ListView.builder(scrollDirection: Axis.vertical, padding: EdgeInsets.all(10), itemCount: 1, itemBuilder: (c, i) {
         return Column(
             children: <Widget>[
               Container(
                 height: 60,
                 margin: EdgeInsets.all(20),
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                     color: Colors.white,
                     border: (
                         Border.all(width: 1, color: Colors.grey,)
                     )
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.roller_skating_rounded, color: Colors.blue), Text('2,000 걸음', style: TextStyle(fontSize: 15)
                     ),Spacer(flex: 30,),ElevatedButton(style: TextButton.styleFrom(backgroundColor: Colors.grey),
                         onPressed: () {}, child: Text("1 포인트"),
                       ),
                   ],
                 ),
               ),
               Container(
                 height: 60,
                 margin: EdgeInsets.all(20),
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                     color: Colors.white,
                     border: (
                         Border.all(width: 1, color: Colors.grey,)
                     )
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Icon(Icons.roller_skating_rounded, color: Colors.blue), Text('5,000 걸음', style: TextStyle(fontSize: 15),
                     ),Spacer(flex: 30,),ElevatedButton(style: TextButton.styleFrom(backgroundColor: Colors.grey),
                       onPressed: () {},
                       child: Text("2 포인트"),
                     ),
                   ],
                 ),
               ),
               Container(
                 height: 60,
                 margin: EdgeInsets.all(20),
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                     color: Colors.white,
                     border: (
                         Border.all(width: 1, color: Colors.grey,)
                     )
                 ),
                 child: Row(
                   children: [
                     Icon(Icons.roller_skating_rounded, color: Colors.blue), Text('10,000 걸음', style: TextStyle(fontSize: 15)),
                     Spacer(flex: 30,),ElevatedButton(
                       style: TextButton.styleFrom(backgroundColor: Colors.grey),
                       onPressed: () {},
                       child: Text("3 포인트"),
                     ),
                   ],
                 ),
               ),
             ],
         );
       },
      ),
     ),
    );
  }
}

