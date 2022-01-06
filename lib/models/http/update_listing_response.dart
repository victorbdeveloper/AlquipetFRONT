// To parse this JSON data, do
//
//     final updateListingResponse = updateListingResponseFromMap(jsonString);

import 'dart:convert';

class UpdateListingResponse {
  UpdateListingResponse({
    required this.msg,
    required this.listing,
  });

  String msg;
  Listing listing;

  factory UpdateListingResponse.fromJson(String str) =>
      UpdateListingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateListingResponse.fromMap(Map<String, dynamic> json) =>
      UpdateListingResponse(
        msg: json["msg"],
        listing: Listing.fromMap(json["listing"]),
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "listing": listing.toMap(),
      };

  @override
  String toString() {
    return 'UpdateListingResponse{msg: $msg, listing: $listing}';
  }
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

  CreatedBy createdBy;
  bool state;
  Address address;
  PetsAllowed petsAllowed;
  List<Photo> photos;
  int price;
  String description;
  DateTime datePublication;
  String uid;

  factory Listing.fromJson(String str) => Listing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listing.fromMap(Map<String, dynamic> json) => Listing(
        createdBy: CreatedBy.fromMap(json["created_by"]),
        state: json["state"],
        address: Address.fromMap(json["address"]),
        petsAllowed: PetsAllowed.fromMap(json["pets_allowed"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromMap(x))),
        price: json["price"],
        description: json["description"],
        datePublication: DateTime.parse(json["date_publication"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "created_by": createdBy.toMap(),
        "state": state,
        "address": address.toMap(),
        "pets_allowed": petsAllowed.toMap(),
        "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
        "price": price,
        "description": description,
        "date_publication": datePublication.toIso8601String(),
        "uid": uid,
      };

  @override
  String toString() {
    return 'Listing{createdBy: $createdBy, state: $state, address: $address, petsAllowed: $petsAllowed, photos: $photos, price: $price, description: $description, datePublication: $datePublication, uid: $uid}';
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
      };

  @override
  String toString() {
    return 'Address{id: $id, province: $province, municipality: $municipality, postalCode: $postalCode, street: $street, number: $number, flour: $flour, letter: $letter, latitude: $latitude, longitude: $longitude}';
  }
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.userName,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  String id;
  String userName;
  String name;
  String lastName;
  String email;
  String phone;

  factory CreatedBy.fromJson(String str) => CreatedBy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatedBy.fromMap(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        userName: json["user_name"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "user_name": userName,
        "name": name,
        "last_name": lastName,
        "email": email,
        "phone": phone,
      };

  @override
  String toString() {
    return 'CreatedBy{id: $id, userName: $userName, name: $name, lastName: $lastName, email: $email, phone: $phone}';
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
  });

  String id;
  bool dogs;
  bool cats;
  bool birds;
  bool rodents;
  bool exotic;
  String others;

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
        others: json["others"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "dogs": dogs,
        "cats": cats,
        "birds": birds,
        "rodents": rodents,
        "exotic": exotic,
        "others": others,
      };

  @override
  String toString() {
    return 'PetsAllowed{id: $id, dogs: $dogs, cats: $cats, birds: $birds, rodents: $rodents, exotic: $exotic, others: $others}';
  }
}

class Photo {
  Photo({
    required this.id,
    required this.fileName,
    required this.publicIdCloudinary,
    required this.urlCloudinary,
  });

  String id;
  String fileName;
  String publicIdCloudinary;
  String urlCloudinary;

  factory Photo.fromJson(String str) => Photo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        id: json["_id"],
        fileName: json["file_name"],
        publicIdCloudinary: json["public_id_cloudinary"],
        urlCloudinary: json["url_cloudinary"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "file_name": fileName,
        "public_id_cloudinary": publicIdCloudinary,
        "url_cloudinary": urlCloudinary,
      };

  @override
  String toString() {
    return 'Photo{id: $id, fileName: $fileName, publicIdCloudinary: $publicIdCloudinary, urlCloudinary: $urlCloudinary}';
  }
}
