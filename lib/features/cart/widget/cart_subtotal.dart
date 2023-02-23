import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map(
          (item) => sum += item['quantity'] * item['product']['price'] as int,
        )
        .toList();
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            "Sub Total ",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            "₹ ${sum}",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
