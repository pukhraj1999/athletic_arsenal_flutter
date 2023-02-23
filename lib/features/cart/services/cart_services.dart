import 'dart:convert';

import 'package:athleticarsenal/constants/error_handling.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/utils.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:athleticarsenal/models/user.dart';
import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/addtocart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          //updating user in provider
          userProvider.setUserFromModel(user);
          ShowSnackBar(context, "Added to Cart!!");
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/user/removefromcart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          //updating user in provider
          userProvider.setUserFromModel(user);
          ShowSnackBar(context, "Removed from Cart!!");
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }
}
