import "package:alquipet_front/api/alquipet_api.dart";
import "package:alquipet_front/models/http/filtered_listings_response.dart";
import 'package:alquipet_front/providers/auth_provider.dart';
import "package:get/get.dart";

class FavoritedListingsProvider extends GetxController {
  AuthProvider authProvider = Get.find<AuthProvider>();
  late FilteredListingsResponse filteredListingsResponse;
  bool isListTypeSelected = true;
  bool isPopupMenuOpen = false;
  bool isLoading = false;

  ///DATA PAGINATED
  int currentPage = 1;
  late int totalPages;
  int numberResultsShowed = 10;

  ///QUERY PARAMS
  String idUser = "";
  int? priceMin;
  int? priceMax;
  String province = "";
  bool dogs = false;
  bool cats = false;
  bool birds = false;
  bool rodents = false;
  bool exotic = false;
  bool others = false;
  String orderBy = "date_newest";
  int indexFrom = 1;
  int indexLimit = 10;

  ///
  /// Función que realiza la petición al servidor de manera filtrdda y paginada
  ///
  dynamic getFilteredPaginatedListings() async {
    ///DEFINIR QUERYPARAMS
    final queryParameters = {
      "id_user": authProvider.user!.uid,
      "price_min": priceMin ?? 1,
      "price_max": priceMax ?? 999999,
      "province": province,
      "dogs": dogs,
      "cats": cats,
      "birds": birds,
      "rodents": rodents,
      "exotic": exotic,
      "others": others,
      "order_by": orderBy,
      "index_from": indexFrom,
      "index_limit": indexLimit
    };

    print(authProvider.user!.uid);

    ///REALIZAR PETICIÓN
    try {
      final response = await AlquipetApi.dioGet(
        "/listings/get_filtered_user_favorites_listings_paginated",
        queryParams: queryParameters,
      );

      ///MAPEAR RESPUESTA
      filteredListingsResponse = FilteredListingsResponse.fromMap(response);

      ///ACTUALIZAR VARIABLES
      calculateTotalPages();
      isLoading = false;

      ///REFRESCAR UI
      update(<String>["favoritedListingsPageContent"]);

      return filteredListingsResponse;
    } catch (e) {
      print("Error: $e");
    }
  }

  ///
  /// Función que cambia entre el modo lista y el modo mosaico
  ///
  void changeIsListTypeSelected() {
    isListTypeSelected = !isListTypeSelected;
    update(<String>["favoritedListingsPageContent"]);
  }

  ///
  /// Función que calcula el total de páginas que ocuparán los resultados obtenidos
  ///
  void calculateTotalPages() {
    if (filteredListingsResponse.totalAnunciosEncontradosAplicandoLosFiltros! ==
        0) {
      totalPages = 1;
    } else {
      totalPages = (filteredListingsResponse
                  .totalAnunciosEncontradosAplicandoLosFiltros! /
              numberResultsShowed)
          .ceil();
    }
  }

  ///
  /// Función que resetea todos los filtros
  ///
  void resetFilters() {
    priceMin = null;
    priceMax = null;
    province = "";
    dogs = false;
    cats = false;
    birds = false;
    rodents = false;
    exotic = false;
    others = false;
    orderBy = "date_newest";
    getFilteredPaginatedListings();
  }
}
