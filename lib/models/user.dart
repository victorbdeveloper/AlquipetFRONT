import 'dart:convert';

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
}
