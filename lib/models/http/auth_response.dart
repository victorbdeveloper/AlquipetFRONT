import 'dart:convert';

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

  @override
  String toString() {
    return 'AuthResponse{msg: $msg, user: $user, token: $token}';
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
  List<String> favoriteListings;
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
            List<String>.from(json["favorite_listings"].map((x) => x)),
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

  @override
  String toString() {
    return 'User{userName: $userName, name: $name, lastName: $lastName, email: $email, phone: $phone, google: $google, state: $state, favoriteListings: $favoriteListings, uid: $uid}';
  }
}
