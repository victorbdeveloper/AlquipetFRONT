import "package:alquipet_front/api/alquipet_api.dart";
import "package:alquipet_front/models/http/listing_response.dart";
import "package:alquipet_front/models/listing.dart";
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
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

  CarouselController buttonCarouselController = CarouselController();

  ///
  ///
  ///
  getListingById(String id) async {
    ///DEFINIR QUERYPARAMS
    final queryParameters = {"id": id};

    ///REALIZAR PETICIÓN
    try {
      var response = await AlquipetApi.dioGet("/listings/get_listing_by_id", queryParams: queryParameters);
      // print("RESPONSE: $response");

      listingResponse = ListingResponse.fromMap(response);
      // print("LISTING RESPONSE: $listingResponse");

      listing = listingResponse.listing!;
      // print("LISTING: $listing");

      ///CARGAR LISTA DE IMÁGENES
      loadImageList();

      return listingResponse;
    } catch (e) {
      print("Error: $e");
    }
  }

  ///
  ///
  ///
  List<Widget> loadImageList() {
    List<Widget> images = <Widget>[];

    if (listing.photos!.isNotEmpty) {
      for (var element in listing.photos!) {
        final image = FadeInImage.assetNetwork(
          placeholder: 'loader.gif',
          image: element.urlCloudinary!,
          // width: 1200,
          // height: 500,
          fit: BoxFit.fill,
        );
        images.add(image);
      }
      return images;
    } else {
      images.add(const Image(
        image: AssetImage('no-image.jpg'),
        // width: 150,
        // height: 150,
        fit: BoxFit.fill,
      ));
    }
    // print(images);
    return images;
  }
}
