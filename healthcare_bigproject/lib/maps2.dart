import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebase = FirebaseFirestore.instance;

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  static final LatLng _kMapCenter =
  LatLng(37.5172, 127.0473);

  // Set<Marker> _createMarker() {
  //   return {
  //     Marker(
  //         markerId: MarkerId("2"),
  //         position: _kMapCenter,
  //         infoWindow: InfoWindow(title: 'Marker 1'),
  //         onTap: (){showDialog(context: context, builder: (context) => AlertDialog(title: Text('Marker1')));},
  //     ),
  //     Marker(
  //       markerId: MarkerId("3"),
  //       position: LatLng(37.501, 127.01),
  //       infoWindow: InfoWindow(title: 'DDD',),
  //       onTap: (){
  //         showDialog(context: context, builder: (context) => );
  //       },
  //     ),
  //   };
  // }

  String address = '' ;
  final Completer<GoogleMapController> _controller = Completer();


  Future<Position> _getUserCurrentLocation() async {


    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace){
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }


  final List<Marker> _markers =  <Marker>[];

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(37.501, 127.01),
    zoom: 14,
  );


  // List<Marker> list = [
  //   Marker(
  //       markerId: MarkerId('1'),
  //       position: LatLng(33.6844, 73.0479),
  //       onTap: (){print("Marker!");},
  //       infoWindow: InfoWindow(
  //           title: 'some Info '
  //       )
  //   ),
  //
  // ];

  getHospitals () async {
    var hospitals = await firebase.collection('hospital_marker').snapshots().first;
    print('hospitals: ${hospitals}');
    print('length : ${hospitals.docs.length}');
    var ls = [];
    for (var i = 0; i < hospitals.docs.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(hospitals.docs[i].data()['lat'], hospitals.docs[i].data()['lng']),
          onTap: (){showDialog(context: context, builder: (context) => TapToHos(data:hospitals.docs[i].data()));},
          infoWindow: InfoWindow(
              title: hospitals.docs[i].data()['name'],
          )
      ));
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals();

    loadData();
  }

  loadData(){
    _getUserCurrentLocation().then((value) async {
      _markers.add(
          Marker(
              markerId: const MarkerId('SomeId'),
              position: LatLng(value.latitude ,value.longitude),
              infoWindow:  InfoWindow(
                  title: address
              )
          )
      );

      final GoogleMapController controller = await _controller.future;
      CameraPosition _kGooglePlex =  CameraPosition(
        target: LatLng(value.latitude ,value.longitude),
        zoom: 14,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffB3D6FF),
        title: Text('Flutter Google Map'),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },
                padding: EdgeInsets.only(
                    bottom:MediaQuery.of(context).size.height*0.15)
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * .1,
            //   decoration: BoxDecoration(
            //       color: Color(0xffB3D6FF),
            //       borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       InkWell(
            //         onTap: (){
            //           _getUserCurrentLocation().then((value) async {
            //             // _markers.add(
            //             //     Marker(
            //             //         markerId: const MarkerId('SomeId'),
            //             //         position: LatLng(value.latitude ,value.longitude),
            //             //         infoWindow:  InfoWindow(
            //             //             title: address
            //             //         )
            //             //     )
            //             // );
            //             final GoogleMapController controller = await _controller.future;
            //
            //             CameraPosition _kGooglePlex =  CameraPosition(
            //               target: LatLng(value.latitude ,value.longitude),
            //               zoom: 14,
            //             );
            //             controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
            //
            //             List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude ,value.longitude);
            //
            //
            //             final add = placemarks.first;
            //             address = add.locality.toString() +" "+add.administrativeArea.toString()+" "+add.subAdministrativeArea.toString()+" "+add.country.toString();
            //             print('********************address: ${address}');
            //           });
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
            //           child: Container(
            //             height: 20,
            //
            //             decoration: BoxDecoration(
            //                 color: Color(0xffB3D6FF),
            //                 borderRadius: BorderRadius.circular(8)
            //             ),
            //             child: Center(child: Text(address , style: TextStyle(color: Colors.black),)),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20),
            //         child: Text(address, style: TextStyle(color: Colors.pink),),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),

      ),
    );
  }


}



class TapToHos extends StatelessWidget {
  const TapToHos({Key? key, this.data}) : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Stack(
          // overflow: Overflow.visible,
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffB3D6FF),
              ),
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hospital Information', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                  Text("Hospital Name: ${data['name']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Text("Wait Num: ${data['n_list']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color:Colors.red)),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Text('Reservation Page'),));
                  }, child: Text('Reservation', style: TextStyle(fontSize: 15))),
                ],
              ),
            ),
            Positioned(
                top: -100,
                child: Image.asset("assets/hospital.png", width: 150, height: 150)
            )
          ],
        )
    );
  }
}
