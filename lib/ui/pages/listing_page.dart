import 'package:alquipet_front/helpers/date_helper.dart';
import "package:alquipet_front/providers/listing_provider.dart";
import "package:alquipet_front/providers/side_menu_provider.dart";
import "package:alquipet_front/ui/buttons/custom_outlined_button.dart";
import "package:alquipet_front/ui/layouts/dashboard_layout.dart";
import 'package:alquipet_front/ui/responsive.dart';
import 'package:alquipet_front/ui/widgets/map_listing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({Key? key}) : super(key: key);

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  late String? id;
  late ListingProvider listingProvider;
  late SideMenuProvider sideMenuProvider;
  bool listingRecibedByParams = true;

  @override
  void initState() {
    listingProvider = Get.find<ListingProvider>();
    sideMenuProvider = Get.find<SideMenuProvider>();

    id = Get.parameters["id"];

    if (Get.arguments == null) {
      ///SI NO HAY ARGUMENTOS PASADOS DESDE LA RUTA ANTERIOR ES QUE SE HA ACCEDIDO PONIENDO LA URL EN EL NAVEGADOR
      listingRecibedByParams = false;
    } else {
      listingProvider.listing = Get.arguments;
    }
    super.initState();
  }

  ///DISPOSE SALTA CUANDO SE PULSA EL BOTÓN DE ATRÁS --> Get.back()
  @override
  void dispose() {
    ///Si se está en formato mvl y con el menu abierto, hay que cerrarlo
    if (Get.width < 650 && SideMenuProvider.isOpen) {
      SideMenuProvider.closeMenu();
    }

    /// Establecer el nombre de la ruta anterior al borrar esta página
    sideMenuProvider.setCurrentPageUrl(Get.previousRoute);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: listingRecibedByParams == true
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: const <Widget>[
                _ListingPageContent(),
              ],
            )
          : FutureBuilder<dynamic>(
              future: listingProvider.getListingById(id!),
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
                                  await listingProvider.getListingById(id!);
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
                        _ListingPageContent(),
                      ],
                    );
                  } else {
                    return Center(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: <Widget>[
                          Center(
                            child: Text(
                                // "No hay datos que mostrar",
                                snapshot.data.toString()),
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

class _ListingPageContent extends StatefulWidget {
  const _ListingPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<_ListingPageContent> createState() => _ListingPageContentState();
}

class _ListingPageContentState extends State<_ListingPageContent> {
  ListingProvider listingProvider = Get.find<ListingProvider>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController municipalityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController flourController = TextEditingController();
  TextEditingController letterController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController datePublicationController = TextEditingController();
  TextEditingController othersPetsController = TextEditingController();

  @override
  void initState() {
    listingProvider = Get.find<ListingProvider>();

    phoneController.text = listingProvider.listing.createdBy!.phone ?? "-";
    emailController.text = listingProvider.listing.createdBy!.email!;
    provinceController.text = listingProvider.listing.address!.province!;
    municipalityController.text = listingProvider.listing.address!.municipality!;
    postalCodeController.text = listingProvider.listing.address!.postalCode!;
    streetController.text = listingProvider.listing.address!.street!;
    numberController.text = listingProvider.listing.address!.number!;
    flourController.text = listingProvider.listing.address!.flour!;
    letterController.text = listingProvider.listing.address!.letter!;
    descriptionController.text = listingProvider.listing.description ?? "";
    datePublicationController.text = DateHelper.getDateShortFormatWithBars(listingProvider.listing.datePublication);
    othersPetsController.text = listingProvider.listing.petsAllowed!.others ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ListingProvider listingProvider = Get.find<ListingProvider>();

    return Hero(
      tag: listingProvider.listing.uid!,
      child: Responsive.isDesktop(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///FOTOS
                Card(
                  child: Column(
                    children: <Widget>[
                      CarouselSlider(
                        items: listingProvider.loadImageList(),
                        carouselController: listingProvider.buttonCarouselController,
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 3.0,
                          initialPage: 2,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => listingProvider.buttonCarouselController
                            .nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear),
                        child: const Text('→'),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ///DATOS CONTACTO
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Flexible(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text(
                                                "DATOS DE CONTACTO:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: <Widget>[
                                                    const Text(
                                                      "Fecha de publicación:",
                                                      style: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 12.0,
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        decoration: const InputDecoration(
                                                          constraints: BoxConstraints(maxHeight: 30),
                                                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                          labelText: "Fecha de publicación",
                                                          labelStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontStyle: FontStyle.italic,
                                                            color: Colors.blue,
                                                          ),
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blue,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                        ),
                                                        controller: datePublicationController,
                                                        readOnly: true,
                                                        onChanged: (value) => {},
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: <Widget>[
                                                    const Text(
                                                      "Teléfono:",
                                                      style: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 12.0,
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        decoration: const InputDecoration(
                                                          constraints: BoxConstraints(maxHeight: 30),
                                                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                          labelText: "Teléfono",
                                                          labelStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontStyle: FontStyle.italic,
                                                            color: Colors.blue,
                                                          ),
                                                          border: OutlineInputBorder(),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blue,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                        ),
                                                        controller: phoneController,
                                                        readOnly: true,
                                                        onChanged: (value) => {},
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: <Widget>[
                                                    const Text(
                                                      "Email:",
                                                      style: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 12.0,
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        decoration: const InputDecoration(
                                                          constraints: BoxConstraints(maxHeight: 30),
                                                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                          labelText: "Correo electrónico",
                                                          labelStyle: TextStyle(
                                                            fontSize: 13,
                                                            fontStyle: FontStyle.italic,
                                                            color: Colors.blue,
                                                          ),
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: Colors.blue,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                        ),
                                                        controller: emailController,
                                                        readOnly: true,
                                                        onChanged: (value) => {},
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          "${listingProvider.listing.price.toString()} €",
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 45.0,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          ///DATOS ANUNCIO
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "DATOS DEL ANUNCIO:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    child: ResponsiveGridList(
                                      minItemWidth: 250,
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Provincia:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Flexible(
                                              child: TextField(
                                                decoration: const InputDecoration(
                                                  constraints: BoxConstraints(maxHeight: 30),
                                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  labelText: "Provincia",
                                                  labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                                controller: provinceController,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Municipio:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Flexible(
                                              child: TextField(
                                                decoration: const InputDecoration(
                                                  constraints: BoxConstraints(maxHeight: 30),
                                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  labelText: "Municipio",
                                                  labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                                controller: municipalityController,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Código Postal:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Flexible(
                                              child: TextField(
                                                decoration: const InputDecoration(
                                                  constraints: BoxConstraints(maxHeight: 30),
                                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  labelText: "Código Postal",
                                                  labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                                controller: postalCodeController,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Calle:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Flexible(
                                              child: TextField(
                                                decoration: const InputDecoration(
                                                  constraints: BoxConstraints(maxHeight: 30),
                                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  labelText: "Calle",
                                                  labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                                controller: streetController,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Número:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Flexible(
                                              child: TextField(
                                                decoration: const InputDecoration(
                                                  constraints: BoxConstraints(maxHeight: 30),
                                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  labelText: "Número",
                                                  labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                                controller: numberController,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Piso:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Flexible(
                                              child: TextField(
                                                decoration: const InputDecoration(
                                                  constraints: BoxConstraints(maxHeight: 30),
                                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  labelText: "Piso",
                                                  labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                                controller: flourController,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Letra:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12.0,
                                            ),
                                            Flexible(
                                              child: TextField(
                                                decoration: const InputDecoration(
                                                  constraints: BoxConstraints(maxHeight: 30),
                                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                  labelText: "Letra",
                                                  labelStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.blue,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                                controller: letterController,
                                                readOnly: true,
                                                onChanged: (value) => {},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (listingProvider.listing.description!.trim().isNotEmpty)
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          "Descripción:",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: TextField(
                                            decoration: const InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                                              labelText: "Descripción",
                                              labelStyle: TextStyle(
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blue,
                                              ),
                                              border: OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            maxLines: null,
                                            controller: descriptionController,
                                            readOnly: true,
                                            onChanged: (value) => {},
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),

                          ///MASCOTAS ADMITIDAS
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "MASCOTAS ADMITIDAS:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    child: ResponsiveGridList(
                                      minItemWidth: 120,
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Perros:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Checkbox(
                                              value: listingProvider.listing.petsAllowed!.dogs!,
                                              visualDensity: const VisualDensity(horizontal: -4),
                                              onChanged: (_) => {},
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Gatos:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Checkbox(
                                              value: listingProvider.listing.petsAllowed!.cats!,
                                              visualDensity: const VisualDensity(horizontal: -4),
                                              onChanged: (_) => {},
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Pájaros:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Checkbox(
                                              value: listingProvider.listing.petsAllowed!.birds!,
                                              visualDensity: const VisualDensity(horizontal: -4),
                                              onChanged: (_) => {},
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Roedores:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Checkbox(
                                              value: listingProvider.listing.petsAllowed!.rodents!,
                                              visualDensity: const VisualDensity(horizontal: -4),
                                              onChanged: (_) => {},
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Exóticas:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Checkbox(
                                              value: listingProvider.listing.petsAllowed!.exotic!,
                                              visualDensity: const VisualDensity(horizontal: -4),
                                              onChanged: (_) => {},
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Text(
                                              "Otras:",
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Checkbox(
                                              value: listingProvider.listing.petsAllowed!.others!.isEmpty ? false : true,
                                              visualDensity: const VisualDensity(horizontal: -4),
                                              onChanged: (_) => {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (listingProvider.listing.petsAllowed!.others!.trim().isNotEmpty)
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          "Otras:",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: TextField(
                                            decoration: const InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                                              labelText: "Otras Mascotas",
                                              labelStyle: TextStyle(
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blue,
                                              ),
                                              border: OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            maxLines: null,
                                            controller: othersPetsController,
                                            readOnly: true,
                                            onChanged: (value) => {},
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    ///MAPA
                    Card(
                      child: Container(
                        color: Colors.orangeAccent,
                        width: Get.width / 4,
                        height: Get.width / 4,
                        child: const MapListing(),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///FOTOS
                Card(
                  child: Column(
                    children: <Widget>[
                      CarouselSlider(
                        items: listingProvider.loadImageList(),
                        // [
                        //         FadeInImage.assetNetwork(
                        //           placeholder: 'loader.gif',
                        //           image: listingProvider.listing.photos!.first.urlCloudinary!,
                        //           // width: 1200,
                        //           // height: 500,
                        //           fit: BoxFit.fill,
                        //         ),
                        //           FadeInImage.assetNetwork(
                        //             placeholder: 'loader.gif',
                        //             image: listingProvider.listing.photos!.last.urlCloudinary!,
                        //             // width: 800,
                        //             // height: 150,
                        //             fit: BoxFit.fill,
                        //           ),
                        //         ]
                        // ,
                        carouselController: listingProvider.buttonCarouselController,
                        options: CarouselOptions(
                          height: Get.height / 3,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 3.0,
                          initialPage: 2,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => listingProvider.buttonCarouselController
                            .nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear),
                        child: const Text('→'),
                      )
                    ],
                  ),
                ),

                // Container(
                //   color: Colors.green,
                //   width: Get.width,
                //   height: Get.height / 3,
                // ),
                // ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ///DATOS CONTACTO
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          "DATOS DE CONTACTO:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Flexible(
                                          child: Row(
                                            children: <Widget>[
                                              const Text(
                                                "Fecha de publicación:",
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Flexible(
                                                child: TextField(
                                                  decoration: const InputDecoration(
                                                    constraints: BoxConstraints(maxHeight: 30),
                                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                    labelText: "Fecha de publicación",
                                                    labelStyle: TextStyle(
                                                      fontSize: 13,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.blue,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  controller: datePublicationController,
                                                  readOnly: true,
                                                  onChanged: (value) => {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Flexible(
                                          child: Row(
                                            children: <Widget>[
                                              const Text(
                                                "Teléfono:",
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Flexible(
                                                child: TextField(
                                                  decoration: const InputDecoration(
                                                    constraints: BoxConstraints(maxHeight: 30),
                                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                    labelText: "Teléfono",
                                                    labelStyle: TextStyle(
                                                      fontSize: 13,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.blue,
                                                    ),
                                                    border: OutlineInputBorder(),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  controller: phoneController,
                                                  readOnly: true,
                                                  onChanged: (value) => {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Flexible(
                                          child: Row(
                                            children: <Widget>[
                                              const Text(
                                                "Email:",
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12.0,
                                              ),
                                              Flexible(
                                                child: TextField(
                                                  decoration: const InputDecoration(
                                                    constraints: BoxConstraints(maxHeight: 30),
                                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                    labelText: "Correo electrónico",
                                                    labelStyle: TextStyle(
                                                      fontSize: 13,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.blue,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  controller: emailController,
                                                  readOnly: true,
                                                  onChanged: (value) => {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "${listingProvider.listing.price.toString()} €",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///DATOS ANUNCIO
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "DATOS DEL ANUNCIO:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: ResponsiveGridList(
                                minItemWidth: 250,
                                shrinkWrap: true,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Provincia:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            labelText: "Provincia",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          controller: provinceController,
                                          readOnly: true,
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Municipio:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            labelText: "Municipio",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          controller: municipalityController,
                                          readOnly: true,
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Código Postal:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            labelText: "Código Postal",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          controller: postalCodeController,
                                          readOnly: true,
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Calle:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            labelText: "Calle",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          controller: streetController,
                                          readOnly: true,
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Número:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            labelText: "Número",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          controller: numberController,
                                          readOnly: true,
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Piso:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            labelText: "Piso",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          controller: flourController,
                                          readOnly: true,
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Letra:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            constraints: BoxConstraints(maxHeight: 30),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                                            labelText: "Letra",
                                            labelStyle: TextStyle(
                                              fontSize: 13,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                            ),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          controller: letterController,
                                          readOnly: true,
                                          onChanged: (value) => {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (listingProvider.listing.description!.trim().isNotEmpty)
                              Row(
                                children: <Widget>[
                                  const Text(
                                    "Descripción:",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        labelText: "Descripción",
                                        labelStyle: TextStyle(
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.blue,
                                        ),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      maxLines: null,
                                      controller: descriptionController,
                                      readOnly: true,
                                      onChanged: (value) => {},
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),

                    ///MASCOTAS ADMITIDAS
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "MASCOTAS ADMITIDAS:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: ResponsiveGridList(
                                minItemWidth: 120,
                                shrinkWrap: true,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Perros:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Checkbox(
                                        value: listingProvider.listing.petsAllowed!.dogs!,
                                        visualDensity: const VisualDensity(horizontal: -4),
                                        onChanged: (_) => {},
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Gatos:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Checkbox(
                                        value: listingProvider.listing.petsAllowed!.cats!,
                                        visualDensity: const VisualDensity(horizontal: -4),
                                        onChanged: (_) => {},
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Pájaros:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Checkbox(
                                        value: listingProvider.listing.petsAllowed!.birds!,
                                        visualDensity: const VisualDensity(horizontal: -4),
                                        onChanged: (_) => {},
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Roedores:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Checkbox(
                                        value: listingProvider.listing.petsAllowed!.rodents!,
                                        visualDensity: const VisualDensity(horizontal: -4),
                                        onChanged: (_) => {},
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Exóticas:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Checkbox(
                                        value: listingProvider.listing.petsAllowed!.exotic!,
                                        visualDensity: const VisualDensity(horizontal: -4),
                                        onChanged: (_) => {},
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Otras:",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Checkbox(
                                        value: listingProvider.listing.petsAllowed!.others!.isEmpty ? false : true,
                                        visualDensity: const VisualDensity(horizontal: -4),
                                        onChanged: (_) => {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (listingProvider.listing.petsAllowed!.others!.trim().isNotEmpty)
                              Row(
                                children: <Widget>[
                                  const Text(
                                    "Otras:",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        labelText: "Otras Mascotas",
                                        labelStyle: TextStyle(
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.blue,
                                        ),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      maxLines: null,
                                      controller: othersPetsController,
                                      readOnly: true,
                                      onChanged: (value) => {},
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                ///MAPA
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Container(
                        color: Colors.orangeAccent,
                        width: 300,
                        height: 300,
                        child: const MapListing(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
