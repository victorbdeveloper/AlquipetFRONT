import "dart:convert";

class Address {
  Address({
    this.id,
    this.province,
    this.municipality,
    this.postalCode,
    this.street,
    this.number,
    this.flour,
    this.letter,
    this.latitude,
    this.longitude,
  });

  String? id = "";
  String? province = "";
  String? municipality = "";
  String? postalCode = "";
  String? street = "";
  String? number = "";
  String? flour = "";
  String? letter = "";
  String? latitude = "";
  String? longitude = "";

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["_id"] = "",
        province: json["province"] = "",
        municipality: json["municipality"] = "",
        postalCode: json["postal_code"] = "",
        street: json["street"] = "",
        number: json["number"] = "",
        flour: json["flour"] = "",
        letter: json["letter"] = "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
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
    return "Address{id: $id, province: $province, municipality: $municipality, postalCode: $postalCode, street: $street, number: $number, flour: $flour, letter: $letter, latitude: $latitude, longitude: $longitude}";
  }
}
