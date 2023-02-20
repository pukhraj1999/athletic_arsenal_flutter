import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (url) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              url,
              fit: BoxFit.cover,
              height: 200,
            ),
          );
        },
      ).toList(), //mapped url to image network and converted into list
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
