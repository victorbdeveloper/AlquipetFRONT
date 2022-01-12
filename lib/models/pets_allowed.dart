import "dart:convert";

class PetsAllowed {
  PetsAllowed({
    this.id,
    this.dogs,
    this.cats,
    this.birds,
    this.rodents,
    this.exotic,
    this.others,
  });

  String? id = "";
  bool? dogs = false;
  bool? cats = false;
  bool? birds = false;
  bool? rodents = false;
  bool? exotic = false;
  String? others = "";

  factory PetsAllowed.fromJson(String str) =>
      PetsAllowed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PetsAllowed.fromMap(Map<String, dynamic> json) => PetsAllowed(
        id: json["_id"] ?? "",
        dogs: json["dogs"] ?? false,
        cats: json["cats"] ?? false,
        birds: json["birds"] ?? false,
        rodents: json["rodents"] ?? false,
        exotic: json["exotic"] ?? false,
        others: json["others"] ?? "",
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
    return "PetsAllowed{id: $id, dogs: $dogs, cats: $cats, birds: $birds, rodents: $rodents, exotic: $exotic, others: $others}";
  }
}
