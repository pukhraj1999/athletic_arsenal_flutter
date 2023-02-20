import 'dart:convert';

import 'package:athleticarsenal/constants/error_handling.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/utils.dart';
import 'package:athleticarsenal/models/product.dart';
import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailServices {
  void reviewProduct({
    required BuildContext context,
    required Product product,
    required String userName,
    required double rating,
    required String review,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/product/review'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'userName': userName,
          'rating': rating,
          'review': review,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Thank you for review and rating!!");
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }
}
