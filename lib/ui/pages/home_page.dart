import "package:alquipet_front/providers/home_provider.dart";
import "package:alquipet_front/ui/buttons/custom_outlined_button.dart";
import 'package:alquipet_front/ui/cards/listing_big_card.dart';
import 'package:alquipet_front/ui/cards/listing_small_card.dart';
import "package:alquipet_front/ui/layouts/dashboard_layout.dart";
import 'package:alquipet_front/ui/widgets/home_filters.dart';
import 'package:alquipet_front/ui/widgets/home_paginated_control.dart';
import 'package:alquipet_front/ui/widgets/page_title.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "package:get/get.dart";
import "package:responsive_grid_list/responsive_grid_list.dart";

import "../responsive.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = Get.find<HomeProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: FutureBuilder<dynamic>(
        future: homeProvider.getFilteredPaginatedListings(),
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
                            await homeProvider.getFilteredPaginatedListings();
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
              return const _HomePageContent();
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

class _HomePageContent extends StatefulWidget {
  const _HomePageContent({Key? key}) : super(key: key);

  @override
  __HomePageContentState createState() => __HomePageContentState();
}

class __HomePageContentState extends State<_HomePageContent> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = Get.find<HomeProvider>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeProvider>(
        init: HomeProvider(),
        id: "homePageContent",
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
                        child: PageTitle("ANUNCIOS"),
                      ),

                      homeProvider.isLoading
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
                                          padding: EdgeInsets.only(bottom: 10.0),
                                          child: HomePaginatedControl(),
                                        ),

                                        homeProvider.filteredListingsResponse.results!.isEmpty
                                            ? const Flexible(
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 18.0),
                                                    child: Text("Ningún resultado obtenido"),
                                                  ),
                                                ),
                                              )
                                            :

                                            ///LISTADO DE ANUNCIOS
                                            homeProvider.isListTypeSelected
                                                ? Flexible(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: const ClampingScrollPhysics(),
                                                      itemCount: homeProvider.filteredListingsResponse.results!.length,
                                                      itemBuilder: (context, index) {
                                                        return Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                          child: GestureDetector(
                                                            onTapUp: (details) {
                                                              Get.toNamed("/anuncio",
                                                                  parameters: {
                                                                    "id": homeProvider.filteredListingsResponse.results![index].uid!
                                                                  },
                                                                  arguments: homeProvider.filteredListingsResponse.results![index]);
                                                            },
                                                            child: Hero(
                                                              tag: homeProvider.filteredListingsResponse.results![index].uid!,
                                                              child: ListingBigCard(
                                                                listing: homeProvider.filteredListingsResponse.results![index],
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
                                                        homeProvider.filteredListingsResponse.results!.length,
                                                        (index) => GestureDetector(
                                                          onTapUp: (details) {
                                                            Get.toNamed("/anuncio",
                                                                parameters: {
                                                                  "id": homeProvider.filteredListingsResponse.results![index].uid!
                                                                },
                                                                arguments: homeProvider.filteredListingsResponse.results![index]);
                                                          },
                                                          child: Hero(
                                                            tag: homeProvider.filteredListingsResponse.results![index].uid!,
                                                            child: ListingSmallCard(
                                                              listing: homeProvider.filteredListingsResponse.results![index],
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
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: const HomeFilters(),
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
                          child: const PageTitle("ANUNCIOS"),
                        ),

                        homeProvider.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            :

                            ///PAGINACIÓN Y FILTROS
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Flexible(
                                      flex: 7,
                                      child: HomePaginatedControl(),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: HomeFilters(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                        homeProvider.filteredListingsResponse.results!.isEmpty
                            ? const Flexible(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 18.0),
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
                                    homeProvider.filteredListingsResponse.results!.length,
                                    (index) => GestureDetector(
                                      onTapUp: (details) {
                                        Get.toNamed("/anuncio",
                                            parameters: {"id": homeProvider.filteredListingsResponse.results![index].uid!},
                                            arguments: homeProvider.filteredListingsResponse.results![index]);
                                      },
                                      child: Hero(
                                        tag: homeProvider.filteredListingsResponse.results![index].uid!,
                                        child: ListingSmallCard(
                                          listing: homeProvider.filteredListingsResponse.results![index],
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
