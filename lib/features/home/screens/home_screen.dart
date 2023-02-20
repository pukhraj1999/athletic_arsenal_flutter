import 'package:athleticarsenal/common/widgets/custom_search_appbar.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/home/widgets/address.dart';
import 'package:athleticarsenal/features/home/widgets/carousel_image.dart';
import 'package:athleticarsenal/features/home/widgets/category.dart';
import 'package:athleticarsenal/features/home/widgets/deal_of_day.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(GlobalVariables.appBarHeight),
        child: CustomSearchAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(height: 10),
            Categories(),
            SizedBox(height: 10),
            CarouselImage(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
