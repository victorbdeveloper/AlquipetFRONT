import "package:alquipet_front/api/alquipet_api.dart";
import "package:alquipet_front/models/http/listing_response.dart";
import "package:alquipet_front/models/listing.dart";
import "package:get/get.dart";

class ListingProvider extends GetxController {
//TODO: CREAR ANUNCIO
//TODO: MODIFICAR ANUNCIO
//TODO: ELIMINAR ANUNCIO
//TODO: ADD ANUNCIO TO FAVORITES
//TODO: DELETE ANUNCIO TO FAVORITES
//TODO: AÑADIR FOTOS AL ANUNCIO
//TODO: QUITAR FOTOS AL ANUNCIO
  late ListingResponse listingResponse;
  late Listing listing;

  dynamic getListingById(String id) async {
    ///DEFINIR QUERYPARAMS
    final queryParameters = {"id": id};

    ///REALIZAR PETICIÓN
    try {
      var response = await AlquipetApi.dioGet("/listings/get_listing_by_id",
          queryParams: queryParameters);
      print("RESPONSE: $response");

      listingResponse = ListingResponse.fromMap(response);
      print("LISTING RESPONSE: $listingResponse");

      listing = listingResponse.listing!;
      print("LISTING: $listing");

      return listingResponse;
    } catch (e) {
      print("Error: $e");
    }
  }
}
