import 'dart:convert';

import '../user.dart';

class AuthResponse {
  AuthResponse({
    required this.msg,
    required this.user,
    required this.token,
  });

  String msg;
  User user;
  String token;

  factory AuthResponse.fromJson(String str) =>
      AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        msg: json["msg"],
        user: User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "user": user.toMap(),
        "token": token,
      };
}
