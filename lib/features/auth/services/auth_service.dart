import 'dart:convert';
import 'package:athleticarsenal/common/widgets/bottom_bar.dart';
import 'package:athleticarsenal/features/admin/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athleticarsenal/constants/error_handling.dart';
import 'package:athleticarsenal/constants/global_Variables.dart';
import 'package:athleticarsenal/constants/utils.dart';
import 'package:athleticarsenal/models/user.dart';
import "package:http/http.dart" as http;
import 'package:athleticarsenal/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signup user
  void signup(
      {required BuildContext context,
      required String firstname,
      required String lastname,
      required String email,
      required String password}) async {
    try {
      User user = User(
        id: '',
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );
      http.Response res = await http.post(Uri.parse('$uri/api/auth/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(
              context, "Account created. Sign in with same credentials!!");
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  // sign in
  void signin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      User user = User(
        id: '',
        firstname: '',
        lastname: '',
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(Uri.parse('$uri/api/auth/signin'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // strong in phone memory like localstorage of web
          SharedPreferences pref = await SharedPreferences.getInstance();
          // outside build function -> listen to false
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await pref.setString(authToken, jsonDecode(res.body)['token']);
          ShowSnackBar(context, "Sign in successfully!!");
          // switch to home screen
          var user = jsonDecode(res.body);
          //redirecting based on type
          switch (user['type']) {
            case 'user':
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomBar.routeName, (route) => false);
              break;
            case 'admin':
              Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (route) => false);
              break;
            default:
              ShowSnackBar(context, "Failed to redirect!!");
              break;
          }
        },
      );
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }

  // getuserdata
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      // ? can be nullable
      String? token = pref.getString(authToken);

      if (token == null) {
        pref.setString(authToken, "");
      }

      http.Response tokenRes = await http.post(
          Uri.parse('$uri/api/auth/tokenisvalid'),
          headers: <String, String>{
            'Content-Type': 'application/json, charset=UTF-8',
            'authToken': token!
          });

      http.Response response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse('$uri/api/auth/getuser'), headers: <String, String>{
          'Content-Type': 'application/json, charset=UTF-8',
          'authToken': token
        });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (err) {
      ShowSnackBar(context, err.toString());
    }
  }
}
