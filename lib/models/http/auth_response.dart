import "dart:convert";

import "../user.dart";

class AuthResponse {
  AuthResponse({
    this.msg,
    this.user,
    this.token,
  });

  String? msg = "";
  User? user;
  String? token = "";

  factory AuthResponse.fromJson(String str) =>
      AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        msg: json["msg"] ?? "",
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "user": user == null ? null : user!.toMap(),
        "token": token,
      };

  @override
  String toString() {
    return "AuthResponse{msg: $msg, user: $user, token: $token}";
  }
}
