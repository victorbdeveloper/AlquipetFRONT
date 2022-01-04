// To parse this JSON data, do
//
//     final getFilteredMyListingsPaginatedResponse = getFilteredMyListingsPaginatedResponseFromMap(jsonString);

import 'dart:convert';

class GetFilteredMyListingsPaginatedResponse {
  GetFilteredMyListingsPaginatedResponse({
    required this.totalAnunciosEncontradosAplicandoLosFiltros,
    required this.anunciosMostrados,
    required this.ndiceDelPrimerAnuncioMostrado,
    required this.ndiceDelLtimoAnuncioMostrado,
    required this.results,
  });

  int totalAnunciosEncontradosAplicandoLosFiltros;
  int anunciosMostrados;
  int ndiceDelPrimerAnuncioMostrado;
  int ndiceDelLtimoAnuncioMostrado;
  List<Result> results;

  factory GetFilteredMyListingsPaginatedResponse.fromJson(String str) =>
      GetFilteredMyListingsPaginatedResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFilteredMyListingsPaginatedResponse.fromMap(
          Map<String, dynamic> json) =>
      GetFilteredMyListingsPaginatedResponse(
        totalAnunciosEncontradosAplicandoLosFiltros:
            json["Total anuncios encontrados aplicando los filtros:"],
        anunciosMostrados: json["Anuncios mostrados: "],
        ndiceDelPrimerAnuncioMostrado:
            json["Índice del primer anuncio mostrado: "],
        ndiceDelLtimoAnuncioMostrado:
            json["Índice del último anuncio mostrado: "],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Total anuncios encontrados aplicando los filtros:":
            totalAnunciosEncontradosAplicandoLosFiltros,
        "Anuncios mostrados: ": anunciosMostrados,
        "Índice del primer anuncio mostrado: ": ndiceDelPrimerAnuncioMostrado,
        "Índice del último anuncio mostrado: ": ndiceDelLtimoAnuncioMostrado,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    required this.createdBy,
    required this.state,
    required this.address,
    required this.petsAllowed,
    required this.photos,
    required this.price,
    required this.datePublication,
    required this.uid,
    required this.description,
  });

  CreatedBy createdBy;
  bool state;
  Address address;
  PetsAllowed petsAllowed;
  List<Photo> photos;
  int price;
  DateTime datePublication;
  String uid;
  String description;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        createdBy: CreatedBy.fromMap(json["created_by"]),
        state: json["state"],
        address: Address.fromMap(json["address"]),
        petsAllowed: PetsAllowed.fromMap(json["pets_allowed"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromMap(x))),
        price: json["price"],
        datePublication: DateTime.parse(json["date_publication"]),
        uid: json["uid"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "created_by": createdBy.toMap(),
        "state": state,
        "address": address.toMap(),
        "pets_allowed": petsAllowed.toMap(),
        "photos": List<dynamic>.from(photos.map((x) => x.toMap())),
        "price": price,
        "date_publication": datePublication.toIso8601String(),
        "uid": uid,
        "description": description == null ? null : description,
      };
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
        others: json["others"] == null ? null : json["others"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "dogs": dogs,
        "cats": cats,
        "birds": birds,
        "rodents": rodents,
        "exotic": exotic,
        "others": others == null ? null : others,
      };
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
}
