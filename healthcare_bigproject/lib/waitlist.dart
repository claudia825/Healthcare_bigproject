import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:styled_widget/styled_widget.dart';

final auth = FirebaseAuth.instance;
final firebase = FirebaseFirestore.instance;

class Reservations extends StatefulWidget {
  Reservations({Key? key}) : super(key: key);

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  var ls = [];

  refreshFunc() {
    setState(() {
      getList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  getList() async {
    ls = [];
    var uid = auth.currentUser?.uid;
    var reservations =
        await firebase.collection('reservation').doc(uid.toString()).get();

    for (var i = 0; i < reservations['info'].length; i++) {
      var doctors = await firebase
          .collection('hospital')
          .doc(reservations['info'][i]['hospital'].toString())
          .get();
      var order = doctors['doctor'][reservations['info'][i]['doctor']]
              ['waitList']
          .indexOf(uid.toString());
      print(order.runtimeType);
      ls.add({
        'Hospital': reservations['info'][i]['hospital'].toString(),
        'Doctor': reservations['info'][i]['doctor'].toString(),
        'Queue': order
      });
    }

    // 새로고침 용
    setState(() {});
  }

  // changeLs(id) {
  //   setState(() {
  //     ls.removeWhere((item) => item['id'] == id);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('ls: ${ls}');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reservations'),
        elevation: 0,
        leading: BackButton(color: Colors.blue),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10),
        itemCount: ls.length, //length로 수정
        itemBuilder: (c, i) {
          return waitentry(i: i, ls: ls, refreshFunc: refreshFunc);
        },
      ),
    );
  }
}

class waitentry extends StatelessWidget {
  const waitentry({Key? key, this.i, this.ls, this.refreshFunc})
      : super(key: key);
  final i;
  final ls;
  final refreshFunc;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Color(0xff82b3e3),
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Color(0xff82b3e3),
      ),
      // color: Color(0xff82b3e3),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            waitlight(order: ls[i]['Queue']),
            Text('Hospital : ${ls[i]['Hospital']}'),
            Text('Doctor : ${ls[i]['Doctor']}'),
            // Text('Order : ${ls[i]['Queue']}'),
            OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5);
                      }
                      return Colors.grey[300]; // Use the component's default.
                    },
                  ),
                ),
                child: Text('취소하기'),
                onPressed: () async {
                  var data = await firebase
                      .collection('hospital')
                      .doc(ls[i]['Hospital'])
                      .get();
                  print(data['doctor']);
                  print(ls[i]['Queue'].runtimeType);
                  // var temp = data['doctor'][ls[i]['Doctor']]['waitList'].removeAt(ls[i]['Queue']);
                  var temp = data['doctor'];
                  print(temp);
                  temp[ls[i]['Doctor']]['waitList'].removeAt(ls[i]['Queue']);
                  print(temp);
                  await firebase
                      .collection('hospital')
                      .doc(ls[i]['Hospital'])
                      .update({'doctor': temp});
                  var reservation = await firebase
                      .collection('reservation')
                      .doc(auth.currentUser?.uid)
                      .get();
                  print(reservation['info']);
                  var tempLs = reservation['info'];
                  print(tempLs.runtimeType);
                  tempLs.removeWhere((item) =>
                      item['doctor'] == ls[i]['Doctor'] &&
                      item['hospital'] == ls[i]['Hospital']);
                  print(tempLs);
                  await firebase
                      .collection('reservation')
                      .doc(auth.currentUser?.uid)
                      .update({'info': tempLs});
                  // await firebase.collection('hospital').doc(ls[i]['Hospital'])
                  refreshFunc();
                }),
          ]),
    );
  }
}

class waitlight extends StatelessWidget {
  const waitlight({Key? key, this.order}) : super(key: key);
  final order;

  @override
  Widget build(BuildContext context) {
    var w = '0' * (3 - order.toString().length) + order.toString();
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (w == '000')
              ? Text('${w} : Wait Status  ', style: TextStyle(fontSize: 15))
              : Text('${w} : Wait Status  ', style: TextStyle(fontSize: 10)),
          //대기중, 완료 등 색상 if문 처리
          (w == '000')
              ? Icon(
                  Icons.circle,
                  size: 8,
                  color: Colors.green,
                )
              : Icon(Icons.circle, size: 8, color: Colors.red)
        ],
      ),
    );
  }
}

class WaitList extends StatelessWidget {
  const WaitList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('대기 현황 Wait List', style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(
            child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                height: 70,
                color: Colors.white,
                child: Text('ex) 대기 3번째입니다.')))
      ],
    );
  }
}
