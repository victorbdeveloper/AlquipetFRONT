import 'package:alquipet_front/providers/home_provider.dart';
import 'package:alquipet_front/ui/buttons/custom_outlined_button.dart';
import 'package:alquipet_front/ui/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../responsive.dart';

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
                          'Ha sucedido algo inesperado',
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
              return ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: const <Widget>[
                  _HomePageContent(),
                ],
              );
            } else {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: const <Widget>[
                    Center(
                      child: Text(
                        'No hay datos que mostrar',
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
                      'State: ${snapshot.connectionState}',
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Responsive.isDesktop(context)
          ? Column(
              children: <Widget>[
                ///TÍTULO
                Text("ANUNCIOS"),

                ///FILTROS
                SizedBox(
                  height: 30.0,
                  width: Get.width,
                  child: Container(
                    color: Colors.green,
                  ),
                ),

                ///LISTA CON ANUNCIOS
                ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount:
                      homeProvider.filteredListingsResponse.results!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapUp: (details) {
                        Get.toNamed("/anuncio",
                            parameters: {
                              "id": homeProvider
                                  .filteredListingsResponse.results![index].uid!
                            },
                            arguments: homeProvider
                                .filteredListingsResponse.results![index]);
                      },
                      child: Hero(
                        tag: homeProvider
                            .filteredListingsResponse.results![index].uid!,
                        child: Card(
                          child: Text(
                            homeProvider
                                .filteredListingsResponse.anunciosMostrados
                                .toString(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          : Responsive.isTablet(context)
              ? ResponsiveGridList(
                  shrinkWrap: true,
                  horizontalGridMargin: 50,
                  verticalGridMargin: 50,
                  minItemWidth: 100,
                  children: List.generate(
                    homeProvider.filteredListingsResponse.results!.length,
                    (index) => GestureDetector(
                      onTapUp: (details) {
                        Get.toNamed("/anuncio",
                            parameters: {
                              "id": homeProvider
                                  .filteredListingsResponse.results![index].uid!
                            },
                            arguments: homeProvider
                                .filteredListingsResponse.results![index]);
                      },
                      child: Hero(
                        tag: homeProvider
                            .filteredListingsResponse.results![index].uid!,
                        child: Card(
                          child: Text(
                            homeProvider
                                .filteredListingsResponse.anunciosMostrados
                                .toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Responsive.isMobile(context)
                  ? ResponsiveGridList(
                      shrinkWrap: true,
                      horizontalGridMargin: 50,
                      verticalGridMargin: 50,
                      minItemWidth: 200,
                      children: List.generate(
                        homeProvider.filteredListingsResponse.results!.length,
                        (index) => GestureDetector(
                          onTapUp: (details) {
                            Get.toNamed("/anuncio",
                                parameters: {
                                  "id": homeProvider.filteredListingsResponse
                                      .results![index].uid!
                                },
                                arguments: homeProvider
                                    .filteredListingsResponse.results![index]);
                          },
                          child: Hero(
                            tag: homeProvider
                                .filteredListingsResponse.results![index].uid!,
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Card(
                                child: Text(
                                  homeProvider.filteredListingsResponse
                                      .anunciosMostrados
                                      .toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
    );
  }
}
