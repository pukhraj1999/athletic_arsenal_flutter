import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/account/widgets/account_features.dart';
import 'package:athleticarsenal/features/account/widgets/account_heading.dart';
import 'package:athleticarsenal/features/account/widgets/account_orders.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            //flexible space for linear gradient
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Athletic Arsenal",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: GlobalVariables.backgroundColor,
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: GlobalVariables.backgroundColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            AccountHeading(),
            SizedBox(height: 10),
            AccountFeatures(),
            SizedBox(height: 20),
            AccountOrders()
          ],
        ));
  }
}
