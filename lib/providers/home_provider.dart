import 'package:alquipet_front/api/alquipet_api.dart';
import 'package:get/get.dart';

class HomeProvider extends GetxController {
//TODO: INCLUIR LA CARGA INICIAL DE LOS DATOS DE LA PG, OBTENER ANUNCIOS TOTALES Y FILTRADOS
  dynamic testPeticion() async {
    ///DEFINIR QUERYPARAMS
    // final queryParameters = {'id': '61ac01f8ccec88e05fe6be23'};
    final queryParameters = {};

    ///DEFINIR BODY/DATA
    // final data = {'email': 'test01@test.com', 'password': '123456'};
    final data = {};

    ///REALIZAR PETICIÓN
    try {
      ///EJEMPLO PETICIÓN GET
      // var response = await AlquipetApi.dioGet('/users/get_user',queryParams: queryParameters);
      ///EJEMPLO PETICIÓN POST
      // var response = await AlquipetApi.dioPost('/listings/get_filtered_listing_paginated',
      //     queryParams: queryParameters, body: data);
      var response = await AlquipetApi.dioGet(
        '/listings/get_filtered_listing_paginated',
      );
      print(response);
      return response;
    } catch (e) {
      print("Error: $e");
    }
  }
}
