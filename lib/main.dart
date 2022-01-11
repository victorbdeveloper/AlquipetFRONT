import "package:alquipet_front/api/alquipet_api.dart";
import "package:alquipet_front/providers/auth_provider.dart";
import 'package:alquipet_front/providers/favorited_listings_provider.dart';
import "package:alquipet_front/providers/home_provider.dart";
import "package:alquipet_front/providers/listing_provider.dart";
import 'package:alquipet_front/providers/listings_user_provider.dart';
import "package:alquipet_front/providers/side_menu_provider.dart";
import "package:alquipet_front/routes/routes.dart";
import "package:alquipet_front/services/local_storage.dart";
import "package:alquipet_front/services/notifications_service.dart";
import "package:alquipet_front/ui/pages/not_found_page.dart";
import "package:flutter/material.dart";
import 'package:form_builder_validators/localization/l10n.dart';
import "package:get/get.dart";
import "package:get/get_navigation/src/root/get_material_app.dart";
import "package:url_strategy/url_strategy.dart";

//TODO: COMANDO PARA EJECUTAR FLUTTER DESDE TERMINAL POR UN PUERTO ESPECÍFICO
///flutter run -d chrome --web-port=8082

Future<void> main() async {
  ///Eliminar # de las rutas
  setPathUrlStrategy();

  ///Cargar localStorage / SharedPreferences
  await LocalStorage.configurePrefs();

  ///Inicializar configuración de DIO para las peticiones http
  AlquipetApi.configureDio();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///PROVIDERS
    Get.put(AuthProvider());
    Get.put(FavoritedListingsProvider());
    Get.put(HomeProvider());
    Get.put(ListingProvider());
    Get.put(ListingsUserProvider());
    Get.put(SideMenuProvider());

    return GetMaterialApp(
      ///TÍTULO
      title: "Alquipet",

      ///KEY DEL NOTIFICATION SERVICE
      scaffoldMessengerKey: NotificationsService.messengerKey,

      ///DELEGATES
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],

      ///THEME
      //theme: myLightTheme, //TODO: DESCOMENTAR CUANDO EL THEME ESTE OK

      ///ROUTES
      unknownRoute: GetPage(
        name: "/not_found",
        page: () => const NotFoundPage(),
        transition: Transition.noTransition,
      ),
      initialRoute: "/",
      getPages: routes(),
    );
  }
}

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CustomOutlinedButton(
//             onPressed: () {
//               print("a");
//               Get.toNamed("/second", parameters: {"a": "1", "b": "2"});
//             },
//             text: "IR A PG 2"),
//       ),
//     );
//   }
// }
//
// class Second extends StatelessWidget {
//   const Second({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CustomOutlinedButton(
//             onPressed: () {
//               print("a");
//             },
//             text: "IR A HOME"),
//       ),
//     );
//   }
// }
