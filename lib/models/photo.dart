import 'dart:convert';

class Photo {
  Photo({
    this.id,
    this.fileName,
    this.publicIdCloudinary,
    this.urlCloudinary,
  });

  String? id = "";
  String? fileName = "";
  String? publicIdCloudinary = "";
  String? urlCloudinary = "";

  factory Photo.fromJson(String str) => Photo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        id: json["_id"] ?? "",
        fileName: json["file_name"] ?? "",
        publicIdCloudinary: json["public_id_cloudinary"] ?? "",
        urlCloudinary: json["url_cloudinary"] ?? "",
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
