import 'dart:convert';

class User {
  User({
    this.userName,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.google,
    this.state,
    this.favoriteListings,
    this.uid,
  });

  String? userName = "";
  String? name = "";
  String? lastName = "";
  String? email = "";
  String? phone = "";
  bool? google;
  bool? state;
  List<String>? favoriteListings = <String>[];
  String? uid;

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
        favoriteListings: json["favorite_listings"] == null
            ? null
            : List<String>.from(json["favorite_listings"].map((x) => x)),
        uid: json["uid"] ?? json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "user_name": userName,
        "name": name,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "google": google,
        "state": state,
        "favorite_listings": favoriteListings == null
            ? null
            : List<dynamic>.from(favoriteListings!.map((x) => x)),
        "uid": uid,
      };

  @override
  String toString() {
    return 'User{userName: $userName, name: $name, lastName: $lastName, email: $email, phone: $phone, google: $google, state: $state, favoriteListings: $favoriteListings, uid: $uid}';
  }
}
