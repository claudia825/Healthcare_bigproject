import 'package:flutter/material.dart';
import './drawer.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  var scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
        title: Text('헬스 케어 앱 이름'),
      ),
      body: Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
            // title: Text('example')),
        ),
        body:Container(
          padding:EdgeInsets.all(20) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('근처 병원'),
              Image.asset('google_map.png', width: 300),
              Text('위치 기반 리스트업'),
              Container(color: Colors.white,
                height:200,
                child: ListView.builder(
                controller: scroll,
                itemCount: 10,
                itemBuilder: (context, i) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(0, 0, 0, 0.01),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 0, 0, 0.05)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => Text('병원 및 의사 정보')));
                      },
                      child: Container(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(child: Text('병원 이름'),),
                            SizedBox(child: Text('의사 이름'),),
                            SizedBox(child: Text('진료과'),),
                            SizedBox(child: Text('대기 명수'),),
                          ],),
                      ),
                    ),
                  );
                })
          )
        ])
    ),
      ),
      drawer: MainDrawer(),
    );
  }
}


