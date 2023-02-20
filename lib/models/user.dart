import 'dart:convert';

class User {
  final String id;
  final String token;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String address;
  final String type;

  User(
      {required this.id,
      required this.token,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.address,
      required this.type});

  // json serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  // json serialization end
}
