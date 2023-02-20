import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class CustomSearchAppBar extends StatefulWidget {
  @override
  State<CustomSearchAppBar> createState() => _CustomSearchAppBarState();
}

class _CustomSearchAppBarState extends State<CustomSearchAppBar> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

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
          Expanded(
            child: Container(
              height: 42,
              margin: EdgeInsets.only(left: 15),
              //material give some elevation and border radius
              child: Material(
                borderRadius: BorderRadius.circular(7),
                elevation: 1,
                child: TextFormField(
                  onFieldSubmitted: navigateToSearchScreen,
                  decoration: InputDecoration(
                    hintText: 'Search Athletic Arsenal',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                    //Inkwell gives splash effect
                    prefixIcon: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(top: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide: BorderSide(
                        color: Colors.black38,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.mic,
              size: 25,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
