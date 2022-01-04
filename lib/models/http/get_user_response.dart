// To parse this JSON data, do
//
//     final getUserResponse = getUserResponseFromMap(jsonString);

import 'dart:convert';

class GetUserResponse {
  GetUserResponse({
    required this.msg,
    required this.user,
  });

  String msg;
  User user;

  factory GetUserResponse.fromJson(String str) =>
      GetUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetUserResponse.fromMap(Map<String, dynamic> json) => GetUserResponse(
        msg: json["msg"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "user": user.toMap(),
      };
}

class User {
  User({
    required this.userName,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.google,
    required this.state,
    required this.favoriteListings,
    required this.uid,
  });

  String userName;
  String name;
  String lastName;
  String email;
  String phone;
  bool google;
  bool state;
  List<dynamic> favoriteListings;
  String uid;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        userName: json["user_name"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        google: json["google"],
        state: json["state"],
        favoriteListings:
            List<dynamic>.from(json["favorite_listings"].map((x) => x)),
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "name": name,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "google": google,
        "state": state,
        "favorite_listings": List<dynamic>.from(favoriteListings.map((x) => x)),
        "uid": uid,
      };
}
