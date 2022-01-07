import 'dart:convert';

import '../user.dart';

class UserResponse {
  UserResponse({
    this.msg,
    this.user,
  });

  String? msg = "";
  User? user;

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        msg: json["msg"] ?? "",
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "user": user == null ? null : user!.toMap(),
      };

  @override
  String toString() {
    return 'UserResponse{msg: $msg, user: $user}';
  }
}
