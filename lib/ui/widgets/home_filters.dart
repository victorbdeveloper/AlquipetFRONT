import 'package:alquipet_front/providers/home_provider.dart';
import 'package:alquipet_front/ui/responsive.dart';
import "package:flutter/material.dart";
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  _HomeFiltersState createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  HomeProvider homeProvider = Get.find<HomeProvider>();
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
    provinceController.text = homeProvider.province;
    homeProvider.priceMin != null
        ? priceMinController.text = homeProvider.priceMin.toString()
        : priceMinController.text = "";
    homeProvider.priceMax != null
        ? priceMaxController.text = homeProvider.priceMax.toString()
        : priceMaxController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    if (homeProvider.isPopupMenuOpen) {
      Get.back();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeProvider>(
        init: HomeProvider(),
        id: "homeFilters",
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
                                homeProvider.isLoading = true;
                                homeProvider
                                    .update(<String>["homePageContent"]);
                                homeProvider.getFilteredPaginatedListings();
                              },
                              child: const Text("Filtrar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                provinceController.text = "";
                                priceMinController.text = "";
                                priceMaxController.text = "";
                                homeProvider.isLoading = true;
                                homeProvider
                                    .update(<String>["homePageContent"]);
                                homeProvider.resetFilters();
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
                        onChanged: (value) => {homeProvider.province = value},
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
                                  homeProvider.priceMin = int.tryParse(value)
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
                                  homeProvider.priceMax = int.tryParse(value)
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
                      value: homeProvider.dogs,
                      onChanged: (newValue) {
                        setState(() {
                          homeProvider.dogs = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("GATOS"),
                      value: homeProvider.cats,
                      onChanged: (newValue) {
                        setState(() {
                          homeProvider.cats = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("PÁJAROS"),
                      value: homeProvider.birds,
                      onChanged: (newValue) {
                        setState(() {
                          homeProvider.birds = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("ROEDORES"),
                      value: homeProvider.rodents,
                      onChanged: (newValue) {
                        setState(() {
                          homeProvider.rodents = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("MASCOTAS EXÓTICAS"),
                      value: homeProvider.exotic,
                      onChanged: (newValue) {
                        setState(() {
                          homeProvider.exotic = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("OTROS"),
                      value: homeProvider.others,
                      onChanged: (newValue) {
                        setState(() {
                          homeProvider.others = newValue!;
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
                        value: orderByTitle[
                            orderByValue.indexOf(homeProvider.orderBy)],
                        items: orderByTitle.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          homeProvider.orderBy =
                              orderByValue[orderByTitle.indexOf(newVal!)];
                          homeProvider.update(<String>["homeFilters"]);
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
              onCanceled: () => {homeProvider.isPopupMenuOpen = false},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<dynamic>>[
                PopupMenuItem(
                  child: MouseRegion(
                    onHover: (_) => {homeProvider.isPopupMenuOpen = true, print(homeProvider.isPopupMenuOpen)},
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
                                          homeProvider.isPopupMenuOpen = true;
                                          homeProvider.isLoading = true;
                                          homeProvider.update(
                                              <String>["homePageContent"]);
                                          homeProvider
                                              .getFilteredPaginatedListings();
                                        },
                                        child: const Text("Filtrar"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          provinceController.text = "";
                                          priceMinController.text = "";
                                          priceMaxController.text = "";
                                          homeProvider.isLoading = true;
                                          homeProvider.update(
                                              <String>["homePageContent"]);
                                          homeProvider.resetFilters();
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
                                  onChanged: (value) =>
                                      {homeProvider.province = value},
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
                                            homeProvider.priceMin =
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
                                            homeProvider.priceMax =
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
                                value: homeProvider.dogs,
                                onChanged: (newValue) {
                                  setState(() {
                                    homeProvider.dogs = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("GATOS"),
                                value: homeProvider.cats,
                                onChanged: (newValue) {
                                  setState(() {
                                    homeProvider.cats = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("PÁJAROS"),
                                value: homeProvider.birds,
                                onChanged: (newValue) {
                                  setState(() {
                                    homeProvider.birds = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("ROEDORES"),
                                value: homeProvider.rodents,
                                onChanged: (newValue) {
                                  setState(() {
                                    homeProvider.rodents = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("MASCOTAS EXÓTICAS"),
                                value: homeProvider.exotic,
                                onChanged: (newValue) {
                                  setState(() {
                                    homeProvider.exotic = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: const Text("OTROS"),
                                value: homeProvider.others,
                                onChanged: (newValue) {
                                  setState(() {
                                    homeProvider.others = newValue!;
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
                                      .indexOf(homeProvider.orderBy)],
                                  items: orderByTitle.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    homeProvider.orderBy = orderByValue[
                                        orderByTitle.indexOf(newVal!)];
                                    homeProvider
                                        .update(<String>["homeFilters"]);
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
