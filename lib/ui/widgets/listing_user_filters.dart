import 'package:alquipet_front/providers/listings_user_provider.dart';
import 'package:alquipet_front/ui/responsive.dart';
import "package:flutter/material.dart";
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ListingsUserFilters extends StatefulWidget {
  const ListingsUserFilters({Key? key}) : super(key: key);

  @override
  _ListingsUserFiltersState createState() => _ListingsUserFiltersState();
}

class _ListingsUserFiltersState extends State<ListingsUserFilters> {
  ListingsUserProvider listingsUserProvider = Get.find<ListingsUserProvider>();
  TextEditingController provinceController = TextEditingController();
  TextEditingController priceMinController = TextEditingController();
  TextEditingController priceMaxController = TextEditingController();

  List<String> orderByTitle = ["Precio Máximo", "Precio Mínimo", "Más recientes", "Más antiguos"];
  List<String> orderByValue = ["price_max", "price_min", "date_newest", "date_oldest"];

  @override
  void initState() {
    provinceController.text = listingsUserProvider.province;
    listingsUserProvider.priceMin != null
        ? priceMinController.text = listingsUserProvider.priceMin.toString()
        : priceMinController.text = "";
    listingsUserProvider.priceMax != null
        ? priceMaxController.text = listingsUserProvider.priceMax.toString()
        : priceMaxController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    // if (listingsUserProvider.isPopupMenuOpen) {
    //   Get.back();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListingsUserProvider>(
        init: ListingsUserProvider(),
        id: "listingsUserFilters",
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
                                listingsUserProvider.isLoading = true;
                                listingsUserProvider.update(<String>["listingsUserPageContent"]);
                                listingsUserProvider.getFilteredPaginatedListings();
                              },
                              child: const Text("Filtrar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                provinceController.text = "";
                                priceMinController.text = "";
                                priceMaxController.text = "";
                                listingsUserProvider.isLoading = true;
                                listingsUserProvider.update(<String>["listingsUserPageContent"]);
                                listingsUserProvider.resetFilters();
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
                        onChanged: (value) => {listingsUserProvider.province = value},
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
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelText: "Precio\nMín.",
                                  labelStyle: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.integer(context, errorText: "Solo\nNúmeros"),
                                keyboardType: TextInputType.number,
                                controller: priceMinController,
                                onChanged: (value) => {listingsUserProvider.priceMin = int.tryParse(value)},
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
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelText: "Precio\nMáx.",
                                  labelStyle: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: FormBuilderValidators.integer(context, errorText: "Solo\nNúmeros"),
                                keyboardType: TextInputType.number,
                                controller: priceMaxController,
                                onChanged: (value) => {listingsUserProvider.priceMax = int.tryParse(value)},
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
                      value: listingsUserProvider.dogs,
                      onChanged: (newValue) {
                        setState(() {
                          listingsUserProvider.dogs = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("GATOS"),
                      value: listingsUserProvider.cats,
                      onChanged: (newValue) {
                        setState(() {
                          listingsUserProvider.cats = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("PÁJAROS"),
                      value: listingsUserProvider.birds,
                      onChanged: (newValue) {
                        setState(() {
                          listingsUserProvider.birds = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("ROEDORES"),
                      value: listingsUserProvider.rodents,
                      onChanged: (newValue) {
                        setState(() {
                          listingsUserProvider.rodents = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("MASCOTAS EXÓTICAS"),
                      value: listingsUserProvider.exotic,
                      onChanged: (newValue) {
                        setState(() {
                          listingsUserProvider.exotic = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text("OTROS"),
                      value: listingsUserProvider.others,
                      onChanged: (newValue) {
                        setState(() {
                          listingsUserProvider.others = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                        value: orderByTitle[orderByValue.indexOf(listingsUserProvider.orderBy)],
                        items: orderByTitle.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          listingsUserProvider.orderBy = orderByValue[orderByTitle.indexOf(newVal!)];
                          listingsUserProvider.update(<String>["listingsUserFilters"]);
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(color: Colors.white, letterSpacing: 2),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: const Text("FILTROS"),
                ),
              ),
              onCanceled: () => {listingsUserProvider.isPopupMenuOpen = false},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<dynamic>>[
                PopupMenuItem(
                  child: GetBuilder<ListingsUserProvider>(
                      init: ListingsUserProvider(),
                      id: "popupMenuItem",
                      builder: (controller) {
                        return Container(
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
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              listingsUserProvider.isPopupMenuOpen = true;
                                              listingsUserProvider.isLoading = true;
                                              listingsUserProvider.update(<String>["listingsUserPageContent", "popupMenuItem"]);
                                              listingsUserProvider.getFilteredPaginatedListings();
                                            },
                                            child: const Text("Filtrar"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              provinceController.text = "";
                                              priceMinController.text = "";
                                              priceMaxController.text = "";
                                              listingsUserProvider.isLoading = true;
                                              listingsUserProvider.update(<String>["listingsUserPageContent", "popupMenuItem"]);
                                              listingsUserProvider.resetFilters();
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
                                      onChanged: (value) => {listingsUserProvider.province = value},
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
                                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                labelText: "Precio\nMín.",
                                                labelStyle: TextStyle(
                                                  fontSize: 13,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                border: OutlineInputBorder(),
                                              ),
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              validator: FormBuilderValidators.integer(context, errorText: "Solo\nNúmeros"),
                                              keyboardType: TextInputType.number,
                                              controller: priceMinController,
                                              onChanged: (value) => {listingsUserProvider.priceMin = int.tryParse(value)},
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
                                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                labelText: "Precio\nMáx.",
                                                labelStyle: TextStyle(
                                                  fontSize: 13,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                border: OutlineInputBorder(),
                                              ),
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              validator: FormBuilderValidators.integer(context, errorText: "Solo\nNúmeros"),
                                              keyboardType: TextInputType.number,
                                              controller: priceMaxController,
                                              onChanged: (value) => {listingsUserProvider.priceMax = int.tryParse(value)},
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
                                    value: listingsUserProvider.dogs,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listingsUserProvider.dogs = newValue!;
                                        listingsUserProvider.update(<String>["popupMenuItem"]);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: const Text("GATOS"),
                                    value: listingsUserProvider.cats,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listingsUserProvider.cats = newValue!;
                                        listingsUserProvider.update(<String>["popupMenuItem"]);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: const Text("PÁJAROS"),
                                    value: listingsUserProvider.birds,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listingsUserProvider.birds = newValue!;
                                        listingsUserProvider.update(<String>["popupMenuItem"]);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: const Text("ROEDORES"),
                                    value: listingsUserProvider.rodents,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listingsUserProvider.rodents = newValue!;
                                        listingsUserProvider.update(<String>["popupMenuItem"]);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: const Text("MASCOTAS EXÓTICAS"),
                                    value: listingsUserProvider.exotic,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listingsUserProvider.exotic = newValue!;
                                        listingsUserProvider.update(<String>["popupMenuItem"]);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: const Text("OTROS"),
                                    value: listingsUserProvider.others,
                                    onChanged: (newValue) {
                                      setState(() {
                                        listingsUserProvider.others = newValue!;
                                        listingsUserProvider.update(<String>["popupMenuItem"]);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                                      value: orderByTitle[orderByValue.indexOf(listingsUserProvider.orderBy)],
                                      items: orderByTitle.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        listingsUserProvider.orderBy = orderByValue[orderByTitle.indexOf(newVal!)];
                                        listingsUserProvider.update(<String>["popupMenuItem"]);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
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
