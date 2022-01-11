import 'package:alquipet_front/providers/favorited_listings_provider.dart';
import 'package:alquipet_front/ui/responsive.dart';
import "package:flutter/material.dart";
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class FavoritedListingsFilters extends StatefulWidget {
  const FavoritedListingsFilters({Key? key}) : super(key: key);

  @override
  _FavoritedListingsFiltersState createState() =>
      _FavoritedListingsFiltersState();
}

class _FavoritedListingsFiltersState extends State<FavoritedListingsFilters> {
  FavoritedListingsProvider favoritedListingsProvider =
      Get.find<FavoritedListingsProvider>();
  TextEditingController provinceController = TextEditingController();
  TextEditingController priceMinController = TextEditingController();
  TextEditingController priceMaxController = TextEditingController();

  List<String> orderByTitle = [
    "Precio Máximo",
    "Precio Mínimo",
    "Más recientes",
    "Más antiguos"
  ];
  List<String> orderByValue = [
    "price_max",
    "price_min",
    "date_newest",
    "date_oldest"
  ];

  @override
  void initState() {
    provinceController.text = favoritedListingsProvider.province;
    favoritedListingsProvider.priceMin != null
        ? priceMinController.text =
            favoritedListingsProvider.priceMin.toString()
        : priceMinController.text = "";
    favoritedListingsProvider.priceMax != null
        ? priceMaxController.text =
            favoritedListingsProvider.priceMax.toString()
        : priceMaxController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    // if (favoritedListingsProvider.isPopupMenuOpen) {
    //   Get.back();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritedListingsProvider>(
        init: FavoritedListingsProvider(),
        id: "favoritedListingsFilters",
        builder: (controller) {
          if (Responsive.isDesktop(context)) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///TÍTULO
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          "FILTROS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            decorationThickness: 2.0,
                          ),
                        ),
                      ),
                    ),

                    ///BOTONES
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                favoritedListingsProvider.isLoading = true;
                                favoritedListingsProvider.update(
                                    <String>["favoritedListingsPageContent"]);
                                favoritedListingsProvider
                                    .getFilteredPaginatedListings();
                              },
                              child: const Text("Filtrar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                provinceController.text = "";
                                priceMinController.text = "";
                                priceMaxController.text = "";
                                favoritedListingsProvider.isLoading = true;
                                favoritedListingsProvider.update(
                                    <String>["favoritedListingsPageContent"]);
                                favoritedListingsProvider.resetFilters();
                              },
                              child: const Text("Reiniciar"),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Divider(),

                    ///PROVINCIA
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 8.0),
                    //   child: Center(
                    //     child: Text("Provincia"),
                    //   ),
                    // ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: "Buscar Provincia",
                          labelStyle: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        controller: provinceController,
                        onChanged: (value) =>
                            {favoritedListingsProvider.province = value},
                      ),
                    ),

                    const Divider(),

                    ///PRECIO
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 8.0),
                    //   child: Center(
                    //     child: Text("Precio"),
                    //   ),
                    // ),
                    IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  labelText: "Precio\nMín.",
                                  labelStyle: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.integer(
                                    context,
                                    errorText: "Solo\nNúmeros"),
                                keyboardType: TextInputType.number,
                                controller: priceMinController,
                                onChanged: (value) => {
                                  favoritedListingsProvider.priceMin =
                                      int.tryParse(value)
                                },
                              ),
                            ),
                          ),
                          const VerticalDivider(),
                          Flexible(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  labelText: "Precio\nMáx.",
                                  labelStyle: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.integer(
                                    context,
                                    errorText: "Solo\nNúmeros"),
                                keyboardType: TextInputType.number,
                                controller: priceMaxController,
                                onChanged: (value) => {
                                  favoritedListingsProvider.priceMax =
                                      int.tryParse(value)
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(),

                    ///MASCOTAS
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 8.0),
                    //   child: Center(
                    //     child: Text("Mascotas admitidas"),
                    //   ),
                    // ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("PERROS"),
                      value: favoritedListingsProvider.dogs,
                      onChanged: (newValue) {
                        setState(() {
                          favoritedListingsProvider.dogs = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("GATOS"),
                      value: favoritedListingsProvider.cats,
                      onChanged: (newValue) {
                        setState(() {
                          favoritedListingsProvider.cats = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("PÁJAROS"),
                      value: favoritedListingsProvider.birds,
                      onChanged: (newValue) {
                        setState(() {
                          favoritedListingsProvider.birds = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("ROEDORES"),
                      value: favoritedListingsProvider.rodents,
                      onChanged: (newValue) {
                        setState(() {
                          favoritedListingsProvider.rodents = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("MASCOTAS EXÓTICAS"),
                      value: favoritedListingsProvider.exotic,
                      onChanged: (newValue) {
                        setState(() {
                          favoritedListingsProvider.exotic = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("OTROS"),
                      value: favoritedListingsProvider.others,
                      onChanged: (newValue) {
                        setState(() {
                          favoritedListingsProvider.others = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),

                    const Divider(),

                    ///ORDENAR POR
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 8.0),
                    //   child: Center(
                    //     child: Text("Ordenar por"),
                    //   ),
                    // ),
                    DropdownButton<String>(
                        hint: const Text("Pick"),
                        value: orderByTitle[orderByValue
                            .indexOf(favoritedListingsProvider.orderBy)],
                        items: orderByTitle.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          favoritedListingsProvider.orderBy =
                              orderByValue[orderByTitle.indexOf(newVal!)];
                          favoritedListingsProvider
                              .update(<String>["favoritedListingsFilters"]);
                        }),
                  ],
                ),
              ),
            );
          } else {
            return PopupMenuButton(
              child: Material(
                color: Colors.blue,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle:
                    const TextStyle(color: Colors.white, letterSpacing: 2),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: const Text("FILTROS"),
                ),
              ),
              onCanceled: () =>
                  {favoritedListingsProvider.isPopupMenuOpen = false},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<dynamic>>[
                PopupMenuItem(
                  child: MouseRegion(
                    onHover: (_) => {
                      favoritedListingsProvider.isPopupMenuOpen = true,
                    },
                    child: Container(
                      color: Colors.blue.shade100,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ///TÍTULO
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: Text(
                                    "FILTROS",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decorationThickness: 2.0,
                                    ),
                                  ),
                                ),
                              ),

                              ///BOTONES
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                          favoritedListingsProvider
                                              .isPopupMenuOpen = true;
                                          favoritedListingsProvider.isLoading =
                                              true;
                                          favoritedListingsProvider
                                              .update(<String>[
                                            "favoritedListingsPageContent"
                                          ]);
                                          favoritedListingsProvider
                                              .getFilteredPaginatedListings();
                                        },
                                        child: const Text("Filtrar"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          provinceController.text = "";
                                          priceMinController.text = "";
                                          priceMaxController.text = "";
                                          favoritedListingsProvider.isLoading =
                                              true;
                                          favoritedListingsProvider
                                              .update(<String>[
                                            "favoritedListingsPageContent"
                                          ]);
                                          favoritedListingsProvider
                                              .resetFilters();
                                        },
                                        child: const Text("Reiniciar"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const Divider(),

                              ///PROVINCIA
                              // const Padding(
                              //   padding: EdgeInsets.only(bottom: 8.0),
                              //   child: Center(
                              //     child: Text("Provincia"),
                              //   ),
                              // ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    labelText: "Buscar Provincia",
                                    labelStyle: TextStyle(
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: provinceController,
                                  onChanged: (value) => {
                                    favoritedListingsProvider.province = value
                                  },
                                ),
                              ),

                              const Divider(),

                              ///PRECIO
                              // const Padding(
                              //   padding: EdgeInsets.only(bottom: 8.0),
                              //   child: Center(
                              //     child: Text("Precio"),
                              //   ),
                              // ),
                              IntrinsicHeight(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                            labelText: "Precio\nMín.",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            border: OutlineInputBorder(),
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator:
                                              FormBuilderValidators.integer(
                                                  context,
                                                  errorText: "Solo\nNúmeros"),
                                          keyboardType: TextInputType.number,
                                          controller: priceMinController,
                                          onChanged: (value) => {
                                            favoritedListingsProvider.priceMin =
                                                int.tryParse(value)
                                          },
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(),
                                    Flexible(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                            labelText: "Precio\nMáx.",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            border: OutlineInputBorder(),
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator:
                                              FormBuilderValidators.integer(
                                                  context,
                                                  errorText: "Solo\nNúmeros"),
                                          keyboardType: TextInputType.number,
                                          controller: priceMaxController,
                                          onChanged: (value) => {
                                            favoritedListingsProvider.priceMax =
                                                int.tryParse(value)
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Divider(),

                              ///MASCOTAS
                              // const Padding(
                              //   padding: EdgeInsets.only(bottom: 8.0),
                              //   child: Center(
                              //     child: Text("Mascotas admitidas"),
                              //   ),
                              // ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("PERROS"),
                                value: favoritedListingsProvider.dogs,
                                onChanged: (newValue) {
                                  setState(() {
                                    favoritedListingsProvider.dogs = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("GATOS"),
                                value: favoritedListingsProvider.cats,
                                onChanged: (newValue) {
                                  setState(() {
                                    favoritedListingsProvider.cats = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("PÁJAROS"),
                                value: favoritedListingsProvider.birds,
                                onChanged: (newValue) {
                                  setState(() {
                                    favoritedListingsProvider.birds = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("ROEDORES"),
                                value: favoritedListingsProvider.rodents,
                                onChanged: (newValue) {
                                  setState(() {
                                    favoritedListingsProvider.rodents =
                                        newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("MASCOTAS EXÓTICAS"),
                                value: favoritedListingsProvider.exotic,
                                onChanged: (newValue) {
                                  setState(() {
                                    favoritedListingsProvider.exotic =
                                        newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("OTROS"),
                                value: favoritedListingsProvider.others,
                                onChanged: (newValue) {
                                  setState(() {
                                    favoritedListingsProvider.others =
                                        newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),

                              const Divider(),

                              ///ORDENAR POR
                              // const Padding(
                              //   padding: EdgeInsets.only(bottom: 8.0),
                              //   child: Center(
                              //     child: Text("Ordenar por"),
                              //   ),
                              // ),
                              DropdownButton<String>(
                                  hint: const Text("Pick"),
                                  value: orderByTitle[orderByValue.indexOf(
                                      favoritedListingsProvider.orderBy)],
                                  items: orderByTitle.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    favoritedListingsProvider.orderBy =
                                        orderByValue[
                                            orderByTitle.indexOf(newVal!)];
                                    favoritedListingsProvider.update(
                                        <String>["favoritedListingsFilters"]);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                  mouseCursor: SystemMouseCursors.basic,
                  enabled: false,
                )
              ],
            );
          }
        });
  }
}
