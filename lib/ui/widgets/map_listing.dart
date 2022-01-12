import 'package:alquipet_front/providers/listing_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

// <div id='map' style='width: 400px; height: 300px;'></div>
// <script>
// mapboxgl.accessToken = 'pk.eyJ1IjoidmljdG9yYmRldmVsb3BlciIsImEiOiJja3d4dHBnNTEwaWNlMnBxdGVvM2FsaTAyIn0.Ncy2BxXqgcr9H9URKAZbIw';
// const map = new mapboxgl.Map({
//   container: 'map', // container ID
//   style: 'mapbox://styles/mapbox/streets-v11', // style URL
//   center: [-74.5, 40], // starting position [lng, lat]
//   zoom: 9 // starting zoom
// });

class MapListing extends StatefulWidget {
  const MapListing({Key? key}) : super(key: key);

  @override
  State<MapListing> createState() => _MapListingState();
}

class _MapListingState extends State<MapListing> {
  ListingProvider listingProvider = Get.find<ListingProvider>();
  late LatLng latLng;
  late MapboxMapController mapboxMapController;

  @override
  void initState() {
    latLng = LatLng(
      double.parse(listingProvider.listing.address!.latitude!),
      double.parse(listingProvider.listing.address!.longitude!),
    );
    super.initState();
  }

  @override
  void dispose() {
    mapboxMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: "pk.eyJ1IjoidmljdG9yYmRldmVsb3BlciIsImEiOiJja3d4dHBnNTEwaWNlMnBxdGVvM2FsaTAyIn0.Ncy2BxXqgcr9H9URKAZbIw",
        onMapCreated: _onMapCreated,
        onStyleLoadedCallback: () => addCircle(mapboxMapController),
        initialCameraPosition: CameraPosition(target: latLng, zoom: 14),
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) {
    mapboxMapController = controller;
  }

  void addCircle(MapboxMapController controller) {
    controller.addCircle(
      CircleOptions(
        geometry: latLng,
        circleColor: "#23d2aa",
        circleRadius: 15,
      ),
    );
  }
}
