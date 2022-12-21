import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


final imageList = [
  Image.asset('assets/image1.jpg'),
  Image.asset('assets/image2.jpg'),
];

class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: false,
        initialPage: 0,
        viewportFraction: 1.0,
        //enlargeFactor: 1.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),),
      items: imageList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                //width: MediaQuery.of(context).size.width,
                width: double.infinity,
                //margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    color: Colors.grey
                ),
                //child: Text('text $i', style: TextStyle(fontSize: 16.0),)
            );
          },
        );
      }).toList(),
    );
  }
}


