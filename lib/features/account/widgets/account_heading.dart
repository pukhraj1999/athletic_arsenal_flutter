import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //gettin user info
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            "Hi There, ",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            user.firstname + " " + user.lastname,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
