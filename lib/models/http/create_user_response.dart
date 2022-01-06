// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromMap(jsonString);

import 'dart:convert';

class CreateUserResponse {
  CreateUserResponse({
    required this.msg,
    required this.user,
  });

  String msg;
  User user;

  factory CreateUserResponse.fromJson(String str) =>
      CreateUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateUserResponse.fromMap(Map<String, dynamic> json) =>
      CreateUserResponse(
        msg: json["msg"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "user": user.toMap(),
      };

  @override
  String toString() {
    return 'CreateUserResponse{msg: $msg, user: $user}';
  }
}

class User {
  User({
    required this.userName,
    required this.name,
    required this.lastName,
    required this.email,
  });

  String userName;
  String name;
  String lastName;
  String email;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        userName: json["user_name"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "name": name,
        "last_name": lastName,
        "email": email,
      };

  @override
  String toString() {
    return 'User{userName: $userName, name: $name, lastName: $lastName, email: $email}';
  }
}
