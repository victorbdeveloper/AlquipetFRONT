// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromMap(jsonString);

import 'dart:convert';

class UpdateUserResponse {
  UpdateUserResponse({
    required this.msg,
    required this.user,
  });

  String msg;
  User user;

  factory UpdateUserResponse.fromJson(String str) =>
      UpdateUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateUserResponse.fromMap(Map<String, dynamic> json) =>
      UpdateUserResponse(
        msg: json["msg"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() =>
      {
        "msg": msg,
        "user": user.toMap(),
      };

  @override
  String toString() {
    return 'UpdateUserResponse{msg: $msg, user: $user}';
  }
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

  factory User.fromMap(Map<String, dynamic> json) =>
      User(
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

  Map<String, dynamic> toMap() =>
      {
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

  @override
  String toString() {
    return 'User{userName: $userName, name: $name, lastName: $lastName, email: $email, phone: $phone, google: $google, state: $state, favoriteListings: $favoriteListings, uid: $uid}';
  }
}
