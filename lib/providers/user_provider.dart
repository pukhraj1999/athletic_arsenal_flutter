import 'package:flutter/material.dart';
import 'package:athleticarsenal/models/user.dart';

class UserProvider extends ChangeNotifier {
  // _ means private variable
  User _user = User(
    id: '',
    firstname: '',
    lastname: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners(); // user value has been changed so rebuild
  }
}
