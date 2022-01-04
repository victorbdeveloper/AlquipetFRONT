// To parse this JSON data, do
//
//     final deleteListingResponse = deleteListingResponseFromMap(jsonString);

import 'dart:convert';

class DeleteListingResponse {
  DeleteListingResponse({
    required this.msg,
    required this.listing,
  });

  String msg;
  Listing listing;

  factory DeleteListingResponse.fromJson(String str) =>
      DeleteListingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteListingResponse.fromMap(Map<String, dynamic> json) =>
      DeleteListingResponse(
        msg: json["msg"],
        listing: Listing.fromMap(json["listing"]),
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "listing": listing.toMap(),
      };
}

class Listing {
  Listing({
    required this.createdBy,
    required this.state,
    required this.address,
    required this.petsAllowed,
    required this.photos,
    required this.price,
    required this.description,
    required this.datePublication,
    required this.uid,
  });

  String createdBy;
  bool state;
  String address;
  String petsAllowed;
  List<String> photos;
  int price;
  String description;
  DateTime datePublication;
  String uid;

  factory Listing.fromJson(String str) => Listing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listing.fromMap(Map<String, dynamic> json) => Listing(
        createdBy: json["created_by"],
        state: json["state"],
        address: json["address"],
        petsAllowed: json["pets_allowed"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        price: json["price"],
        description: json["description"],
        datePublication: DateTime.parse(json["date_publication"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "created_by": createdBy,
        "state": state,
        "address": address,
        "pets_allowed": petsAllowed,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "price": price,
        "description": description,
        "date_publication": datePublication.toIso8601String(),
        "uid": uid,
      };
}
