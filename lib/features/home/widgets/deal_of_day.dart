import 'package:athleticarsenal/constants/loader.dart';
import 'package:athleticarsenal/features/home/services/home_services.dart';
import 'package:athleticarsenal/features/product_details/screens/product_details.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final homeServices = HomeServices();
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetails.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? LoadingScreen()
        : product!.name.isEmpty
            ? SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          left: 10,
                          top: 15,
                        ),
                        child: Text(
                          "Deal of the Day",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Image.network(
                        product!.images[0],
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 15),
                          alignment: Alignment.topLeft,
                          child: Text(
                            '₹ ${product!.price}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                        child: Text(
                          product!.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (img) => Image.network(
                                  img,
                                  fit: BoxFit.fitWidth,
                                  width: 150,
                                  height: 150,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              );
  }
}
