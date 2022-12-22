import 'package:flutter/material.dart';


class Reservations extends StatefulWidget {
  Reservations({Key? key}) : super(key: key);

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List<Map> ls = [{'id':'0', '접수 시각': '16:24', '병원 명':'세브란스1', '의사 명': '권석원1'},
    {'id':'1', '접수 시각': '16:25', '병원 명':'세브란스2', '의사 명': '권석원2'},
    {'id':'2', '접수 시각': '16:26', '병원 명':'세브란스3', '의사 명': '권석원3'},
    {'id':'3', '접수 시각': '16:27', '병원 명':'세브란스4', '의사 명': '권석원4'},
    {'id':'4', '접수 시각': '16:28', '병원 명':'세브란스5', '의사 명': '권석원5'},
    {'id':'5', '접수 시각': '16:29', '병원 명':'세브란스6', '의사 명': '권석원6'},
    {'id':'6', '접수 시각': '16:30', '병원 명':'세브란스7', '의사 명': '권석원7'},
    {'id':'7', '접수 시각': '16:31', '병원 명':'세브란스8', '의사 명': '권석원8'},
  ];

  changeLs(id) {
    setState(() {
      ls.removeWhere((item) => item['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Reservations'),
          elevation: 0,
          leading: BackButton(color: Colors.blue),
        ),
        body: Scaffold(
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10),
            itemCount: ls.length, //length로 수정
            itemBuilder: (c, i) {
              return waitentry(i:i, ls:ls, changeLs:changeLs);
            },

          ),
        )
    );
  }
}


class waitentry extends StatelessWidget {
  const waitentry({Key? key, this.i, this.ls, this.changeLs}) : super(key: key);
  final i;
  final ls;
  final changeLs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(20),
      //padding: EdgeInsets.all(20),
      color: Colors.white38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          waitlight(),
          Text('접수 시각 : ${ls[i]['접수 시각']}'),
          Text('병원 명 : ${ls[i]['병원 명']}'),
          Text('의사 명 : ${ls[i]['의사 명']}'),
          OutlinedButton(child: Text('취소하기'), onPressed: (){
            changeLs(ls[i]['id']);
          }),
        ] ),
    );
  }
}




class waitlight extends StatelessWidget {
  const waitlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.all(Radius.circular(5),),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('000 : 대기 중  ',style: TextStyle(fontSize: 10)),
          //대기중, 완료 등 색상 if문 처리
          Icon(Icons.circle, size: 8, color: Colors.red,)
        ],
      ),
    );
  }
}

