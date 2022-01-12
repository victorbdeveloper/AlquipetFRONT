import 'package:alquipet_front/providers/listings_user_provider.dart';
import "package:alquipet_front/ui/buttons/custom_outlined_button.dart";
import 'package:alquipet_front/ui/cards/listing_big_card.dart';
import 'package:alquipet_front/ui/cards/listing_small_card.dart';
import "package:alquipet_front/ui/layouts/dashboard_layout.dart";
import 'package:alquipet_front/ui/widgets/listing_user_filters.dart';
import 'package:alquipet_front/ui/widgets/listings_user_paginated_control.dart';
import 'package:alquipet_front/ui/widgets/page_title.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "package:get/get.dart";
import "package:responsive_grid_list/responsive_grid_list.dart";

import "../responsive.dart";

class ListingsUserPage extends StatefulWidget {
  const ListingsUserPage({Key? key}) : super(key: key);

  @override
  State<ListingsUserPage> createState() => _ListingsUserPageState();
}

class _ListingsUserPageState extends State<ListingsUserPage> {
  late ListingsUserProvider listingsUserProvider;

  @override
  void initState() {
    listingsUserProvider = Get.find<ListingsUserProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: FutureBuilder<dynamic>(
        future: listingsUserProvider.getFilteredPaginatedListings(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: const <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Ha sucedido algo inesperado",
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomOutlinedButton(
                          onPressed: () async {
                            await listingsUserProvider
                                .getFilteredPaginatedListings();
                            setState(() {});
                          },
                          text: "Volver a intentar",
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return const _ListingsUserPageContent();
            } else {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: const <Widget>[
                    Center(
                      child: Text(
                        "No hay datos que mostrar",
                      ),
                    )
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  Center(
                    child: Text(
                      "State: ${snapshot.connectionState}",
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _ListingsUserPageContent extends StatefulWidget {
  const _ListingsUserPageContent({Key? key}) : super(key: key);

  @override
  __ListingsUserPageContentState createState() =>
      __ListingsUserPageContentState();
}

class __ListingsUserPageContentState extends State<_ListingsUserPageContent> {
  late ListingsUserProvider listingsUserProvider;

  @override
  void initState() {
    listingsUserProvider = Get.find<ListingsUserProvider>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListingsUserProvider>(
        init: ListingsUserProvider(),
        id: "listingsUserPageContent",
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Responsive.isDesktop(context)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ///TÍTULO
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: PageTitle("MIS ANUNCIOS"),
                      ),

                      listingsUserProvider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          :

                          ///LISTA CON ANUNCIOS
                          Flexible(
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        ///PAGINACIÓN
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.0),
                                          child: ListingsUserPaginatedControl(),
                                        ),

                                        listingsUserProvider
                                                .filteredListingsResponse
                                                .results!
                                                .isEmpty
                                            ? const Flexible(
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 40,
                                                            horizontal: 18.0),
                                                    child: Text(
                                                        "Ningún resultado obtenido"),
                                                  ),
                                                ),
                                              )
                                            :

                                            ///LISTADO DE ANUNCIOS
                                            listingsUserProvider
                                                    .isListTypeSelected
                                                ? Flexible(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const ClampingScrollPhysics(),
                                                      itemCount:
                                                          listingsUserProvider
                                                              .filteredListingsResponse
                                                              .results!
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child:
                                                              GestureDetector(
                                                            onTapUp: (details) {
                                                              Get.toNamed(
                                                                  "/anuncio",
                                                                  parameters: {
                                                                    "id": listingsUserProvider
                                                                        .filteredListingsResponse
                                                                        .results![
                                                                            index]
                                                                        .uid!
                                                                  },
                                                                  arguments: listingsUserProvider
                                                                      .filteredListingsResponse
                                                                      .results![index]);
                                                            },
                                                            child: Hero(
                                                              tag: listingsUserProvider
                                                                  .filteredListingsResponse
                                                                  .results![
                                                                      index]
                                                                  .uid!,
                                                              child:
                                                                  ListingBigCard(
                                                                listing: listingsUserProvider
                                                                    .filteredListingsResponse
                                                                    .results![index],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Flexible(
                                                    child: ResponsiveGridList(
                                                      shrinkWrap: true,
                                                      minItemWidth: 200,
                                                      children: List.generate(
                                                        listingsUserProvider
                                                            .filteredListingsResponse
                                                            .results!
                                                            .length,
                                                        (index) =>
                                                            GestureDetector(
                                                          onTapUp: (details) {
                                                            Get.toNamed(
                                                                "/anuncio",
                                                                parameters: {
                                                                  "id": listingsUserProvider
                                                                      .filteredListingsResponse
                                                                      .results![
                                                                          index]
                                                                      .uid!
                                                                },
                                                                arguments: listingsUserProvider
                                                                    .filteredListingsResponse
                                                                    .results![index]);
                                                          },
                                                          child: Hero(
                                                            tag: listingsUserProvider
                                                                .filteredListingsResponse
                                                                .results![index]
                                                                .uid!,
                                                            child:
                                                                ListingSmallCard(
                                                              listing: listingsUserProvider
                                                                  .filteredListingsResponse
                                                                  .results![index],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Align(
                                      alignment: Alignment.topRight,

                                      ///FILTROS
                                      child: SizedBox(
                                        height: Get.height,
                                        width: 200,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            border: Border.all(
                                              width: 2.0,
                                              color: Colors.blue.shade100,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const ListingsUserFilters(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  )
                : SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ///TÍTULO
                        Padding(
                          padding: EdgeInsets.all(
                            Responsive.isTablet(context) ? 12.0 : 8.0,
                          ),
                          child: const PageTitle("MIS ANUNCIOS"),
                        ),

                        listingsUserProvider.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            :

                            ///PAGINACIÓN Y FILTROS
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Flexible(
                                      flex: 7,
                                      child: ListingsUserPaginatedControl(),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: ListingsUserFilters(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                        listingsUserProvider
                                .filteredListingsResponse.results!.isEmpty
                            ? const Flexible(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 18.0),
                                    child: Text("Ningún resultado obtenido"),
                                  ),
                                ),
                              )
                            :

                            ///LISTADO DE ANUNCIOS
                            Flexible(
                                child: ResponsiveGridList(
                                  shrinkWrap: true,
                                  minItemWidth: 200,
                                  children: List.generate(
                                    listingsUserProvider
                                        .filteredListingsResponse
                                        .results!
                                        .length,
                                    (index) => GestureDetector(
                                      onTapUp: (details) {
                                        Get.toNamed("/anuncio",
                                            parameters: {
                                              "id": listingsUserProvider
                                                  .filteredListingsResponse
                                                  .results![index]
                                                  .uid!
                                            },
                                            arguments: listingsUserProvider
                                                .filteredListingsResponse
                                                .results![index]);
                                      },
                                      child: Hero(
                                        tag: listingsUserProvider
                                            .filteredListingsResponse
                                            .results![index]
                                            .uid!,
                                        child: ListingSmallCard(
                                          listing: listingsUserProvider
                                              .filteredListingsResponse
                                              .results![index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
          );
        });
  }
}
