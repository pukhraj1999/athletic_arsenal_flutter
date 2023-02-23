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
  //cart
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.token,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.address,
      required this.type,
      required this.cart});

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
      'cart': cart,
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
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map((x) => Map<String, dynamic>.from(x)),
      ),
    );
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  // json serialization end

  //deep copy
  User copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
