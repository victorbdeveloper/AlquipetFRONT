// To parse this JSON data, do
//
//     final createListingResponse = createListingResponseFromMap(jsonString);

import 'dart:convert';

class CreateListingResponse {
  CreateListingResponse({
    required this.msg,
    required this.listing,
  });

  String msg;
  Listing listing;

  factory CreateListingResponse.fromJson(String str) =>
      CreateListingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateListingResponse.fromMap(Map<String, dynamic> json) =>
      CreateListingResponse(
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
    required this.datePublication,
    required this.uid,
  });

  String createdBy;
  bool state;
  String address;
  String petsAllowed;
  List<String> photos;
  int price;
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
        "date_publication": datePublication.toIso8601String(),
        "uid": uid,
      };
}
