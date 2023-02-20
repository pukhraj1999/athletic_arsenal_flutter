import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String appbarLeftTitle;
  final String appbarRightTitle;
  const CustomAppBar({
    Key? key,
    this.appbarLeftTitle = "Athletic Arsenal",
    this.appbarRightTitle = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              this.appbarLeftTitle,
              style: TextStyle(
                fontSize: GlobalVariables.appBarTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            this.appbarRightTitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
