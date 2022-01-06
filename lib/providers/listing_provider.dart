import 'package:alquipet_front/api/alquipet_api.dart';
import 'package:alquipet_front/models/http/get_listing_by_id_response.dart';
import 'package:get/get.dart';

class ListingProvider extends GetxController {
//TODO: CREAR ANUNCIO
//TODO: MODIFICAR ANUNCIO
//TODO: ELIMINAR ANUNCIO
//TODO: ADD ANUNCIO TO FAVORITES
//TODO: DELETE ANUNCIO TO FAVORITES
//TODO: AÑADIR FOTOS AL ANUNCIO
//TODO: QUITAR FOTOS AL ANUNCIO
  late GetListingByIdResponse getListingByIdResponse;

  dynamic getListingById(String id) async {
    ///DEFINIR QUERYPARAMS
    final queryParameters = {'id': id};

    ///REALIZAR PETICIÓN
    try {
      print("BBBBBBBB");
      var response = await AlquipetApi.dioGet('/listings/get_listing_by_id',
          queryParams: queryParameters);
      print("RESPONSE: $response");
      getListingByIdResponse = GetListingByIdResponse.fromMap(response);

      print("LISTING: $getListingByIdResponse");
      return getListingByIdResponse;
    } catch (e) {
      print("Error: $e");
    }
  }
}
