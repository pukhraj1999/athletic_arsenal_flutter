import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/features/account/screens/account_screen.dart';
import 'package:athleticarsenal/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges; //from package

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottomBar';
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  //creating pages
  List<Widget> pages = [
    HomeScreen(),
    AccountScreen(),
    Center(
      child: Text("Cart"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //Home
          BottomNavigationBarItem(
              label: '', //required field
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: Icon(
                  Icons.home_outlined,
                ),
              )),
          //Account Or Profile
          BottomNavigationBarItem(
              label: '', //required field
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: Icon(
                  Icons.person_outline_outlined,
                ),
              )),
          //Cart
          BottomNavigationBarItem(
              label: '', //required field
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: bottomBarBorderWidth),
                  ),
                ),
                child: badges.Badge(
                  badgeContent: Text("0"),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
