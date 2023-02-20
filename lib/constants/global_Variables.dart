import 'package:flutter/material.dart';

String uri = "http://192.168.1.6:5000";
String authToken = "authToken";

class GlobalVariables {
  // SIZES
  static const double appBarHeight = 60.0;
  static const double appBarTextSize = 30.0;

  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 66, 58, 216),
      Color.fromARGB(255, 166, 160, 241),
    ],
    stops: [0.5, 1.0],
  );

  static var primaryColor = Color.fromARGB(255, 24, 96, 228);
  static const secondaryColor = Color.fromARGB(255, 0, 42, 255);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 21, 57, 221);
  static const unselectedNavBarColor = Colors.black87;
  static var splashColor = Colors.blueAccent;

// STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];
}
