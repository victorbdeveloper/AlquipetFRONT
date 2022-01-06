// To parse this JSON data, do
//
//     final addListingToFavoritesResponse = addListingToFavoritesResponseFromMap(jsonString);

import 'dart:convert';

class AddListingToFavoritesResponse {
  AddListingToFavoritesResponse({
    required this.msg,
    required this.user,
  });

  String msg;
  User user;

  factory AddListingToFavoritesResponse.fromJson(String str) =>
      AddListingToFavoritesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddListingToFavoritesResponse.fromMap(Map<String, dynamic> json) =>
      AddListingToFavoritesResponse(
        msg: json["msg"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "user": user.toMap(),
      };

  @override
  String toString() {
    return 'AddListingToFavoritesResponse{msg: $msg, user: $user}';
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
  List<FavoriteListing> favoriteListings;
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
        favoriteListings: List<FavoriteListing>.from(
            json["favorite_listings"].map((x) => FavoriteListing.fromMap(x))),
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
        "favorite_listings":
            List<dynamic>.from(favoriteListings.map((x) => x.toMap())),
        "uid": uid,
      };

  @override
  String toString() {
    return 'User{userName: $userName, name: $name, lastName: $lastName, email: $email, phone: $phone, google: $google, state: $state, favoriteListings: $favoriteListings, uid: $uid}';
  }
}

class FavoriteListing {
  FavoriteListing({
    required this.id,
    required this.createdBy,
    required this.state,
    required this.address,
    required this.petsAllowed,
    required this.photos,
    required this.price,
    required this.description,
    required this.datePublication,
    required this.v,
  });

  String id;
  String createdBy;
  bool state;
  Address address;
  PetsAllowed petsAllowed;
  List<Photo> photos;
  int price;
  String description;
  DateTime datePublication;
  int v;

  factory FavoriteListing.fromJson(String str) =>
      FavoriteListing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteListing.fromMap(Map<String, dynamic> json) => FavoriteListing(
        id: json["_id"],
        createdBy: json["created_by"],
        state: json["state"],
        address: Address.fromMap(json["address"]),
        petsAllowed: PetsAllowed.fromMap(json["pets_allowed"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromMap(x))),
        price: json["price"],
        description: json["description"] ?? "",
        datePublication: DateTime.parse(json["date_publication"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "created_by": createdBy,
        "state": state,
        "address": address.toMap(),
        "pets_allowed": petsAllowed.toMap(),
        "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
        "price": price,
        "description": description,
        "date_publication": datePublication.toIso8601String(),
        "__v": v,
      };

  @override
  String toString() {
    return 'FavoriteListing{id: $id, createdBy: $createdBy, state: $state, address: $address, petsAllowed: $petsAllowed, photos: $photos, price: $price, description: $description, datePublication: $datePublication, v: $v}';
  }
}

class Address {
  Address({
    required this.id,
    required this.province,
    required this.municipality,
    required this.postalCode,
    required this.street,
    required this.number,
    required this.flour,
    required this.letter,
    required this.latitude,
    required this.longitude,
    required this.v,
  });

  String id;
  String province;
  String municipality;
  String postalCode;
  String street;
  String number;
  String flour;
  String letter;
  String latitude;
  String longitude;
  int v;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["_id"],
        province: json["province"],
        municipality: json["municipality"],
        postalCode: json["postal_code"],
        street: json["street"],
        number: json["number"],
        flour: json["flour"],
        letter: json["letter"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "province": province,
        "municipality": municipality,
        "postal_code": postalCode,
        "street": street,
        "number": number,
        "flour": flour,
        "letter": letter,
        "latitude": latitude,
        "longitude": longitude,
        "__v": v,
      };

  @override
  String toString() {
    return 'Address{id: $id, province: $province, municipality: $municipality, postalCode: $postalCode, street: $street, number: $number, flour: $flour, letter: $letter, latitude: $latitude, longitude: $longitude, v: $v}';
  }
}

class PetsAllowed {
  PetsAllowed({
    required this.id,
    required this.dogs,
    required this.cats,
    required this.birds,
    required this.rodents,
    required this.exotic,
    required this.others,
    required this.v,
  });

  String id;
  bool dogs;
  bool cats;
  bool birds;
  bool rodents;
  bool exotic;
  String others;
  int v;

  factory PetsAllowed.fromJson(String str) =>
      PetsAllowed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PetsAllowed.fromMap(Map<String, dynamic> json) => PetsAllowed(
        id: json["_id"],
        dogs: json["dogs"],
        cats: json["cats"],
        birds: json["birds"],
        rodents: json["rodents"],
        exotic: json["exotic"],
        others: json["others"] ?? "",
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "dogs": dogs,
        "cats": cats,
        "birds": birds,
        "rodents": rodents,
        "exotic": exotic,
        "others": others,
        "__v": v,
      };

  @override
  String toString() {
    return 'PetsAllowed{id: $id, dogs: $dogs, cats: $cats, birds: $birds, rodents: $rodents, exotic: $exotic, others: $others, v: $v}';
  }
}

class Photo {
  Photo({
    required this.id,
    required this.fileName,
    required this.publicIdCloudinary,
    required this.urlCloudinary,
    required this.v,
  });

  String id;
  String fileName;
  String publicIdCloudinary;
  String urlCloudinary;
  int v;

  factory Photo.fromJson(String str) => Photo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        id: json["_id"],
        fileName: json["file_name"],
        publicIdCloudinary: json["public_id_cloudinary"],
        urlCloudinary: json["url_cloudinary"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "file_name": fileName,
        "public_id_cloudinary": publicIdCloudinary,
        "url_cloudinary": urlCloudinary,
        "__v": v,
      };

  @override
  String toString() {
    return 'Photo{id: $id, fileName: $fileName, publicIdCloudinary: $publicIdCloudinary, urlCloudinary: $urlCloudinary, v: $v}';
  }
}
