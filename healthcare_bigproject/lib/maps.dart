import './drawer.dart';
import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// API : AIzaSyBM5gHrK2EVpzXom8XNeMxXWDgPhfqSW_Q
// AIzaSyCBA76Tr2CJsasR_YVOmY0yX_51e1lvxTg
class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  var scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    // return MapSample();
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
              Image.asset('./assets/google_map.png'),
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


// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }
//
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }