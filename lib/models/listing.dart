import 'dart:convert';

import 'package:alquipet_front/models/address.dart';
import 'package:alquipet_front/models/pets_allowed.dart';
import 'package:alquipet_front/models/photo.dart';
import 'package:alquipet_front/models/user.dart';

class Listing {
  Listing({
    this.createdBy,
    this.state,
    this.address,
    this.petsAllowed,
    this.photos,
    this.price,
    this.description,
    this.datePublication,
    this.uid,
  });

  User? createdBy;
  bool? state;
  Address? address;
  PetsAllowed? petsAllowed;
  List<Photo>? photos = <Photo>[];
  int? price = 0;
  String? description = "";
  DateTime? datePublication;
  String? uid = "";

  factory Listing.fromJson(String str) => Listing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listing.fromMap(Map<String, dynamic> json) => Listing(
        createdBy: json["created_by"] == null
            ? null
            : User.fromMap(json["created_by"]),
        state: json["state"],
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
        petsAllowed: json["pets_allowed"] == null
            ? null
            : PetsAllowed.fromMap(json["pets_allowed"]),
        photos: json["photos"] == null
            ? <Photo>[]
            : List<Photo>.from(json["photos"].map((x) => Photo.fromMap(x))),
        price: json["price"] ?? 0,
        description: json["description"] ?? "",
        datePublication: json["date_publication"] == null
            ? null
            : DateTime.parse(json["date_publication"]),
        uid: json["uid"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "created_by": createdBy == null ? null : createdBy!.toMap(),
        "state": state,
        "address": address == null ? null : address!.toMap(),
        "pets_allowed": petsAllowed == null ? null : petsAllowed!.toMap(),
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos!.map((x) => x.toMap())),
        "price": price,
        "description": description,
        "date_publication":
            datePublication == null ? null : datePublication!.toIso8601String(),
        "uid": uid,
      };

  @override
  String toString() {
    return 'Listing{createdBy: $createdBy, state: $state, address: $address, petsAllowed: $petsAllowed, photos: $photos, price: $price, description: $description, datePublication: $datePublication, uid: $uid}';
  }
}
