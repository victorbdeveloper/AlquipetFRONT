import "dart:convert";

import "../listing.dart";

class ListingResponse {
  ListingResponse({
    this.msg,
    this.listing,
  });

  String? msg = "";
  Listing? listing;

  factory ListingResponse.fromJson(String str) =>
      ListingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListingResponse.fromMap(Map<String, dynamic> json) => ListingResponse(
        msg: json["msg"] ?? "",
        listing:
            json["listing"] == null ? null : Listing.fromMap(json["listing"]),
      );

  Map<String, dynamic> toMap() => {
        "msg": msg,
        "listing": listing == null ? null : listing!.toMap(),
      };
}



