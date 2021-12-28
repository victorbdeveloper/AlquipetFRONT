import 'package:alquipet_front/api/alquipet_api.dart';
import 'package:alquipet_front/providers/auth_provider.dart';
import 'package:alquipet_front/providers/home_provider.dart';
import 'package:alquipet_front/providers/listing_provider.dart';
import 'package:alquipet_front/providers/login_provider.dart';
import 'package:alquipet_front/providers/user_profile_provider.dart';
import 'package:alquipet_front/services/local_storage.dart';
import 'package:alquipet_front/services/notifications_service.dart';
import 'package:alquipet_front/ui/pages/create_listing_page.dart';
import 'package:alquipet_front/ui/pages/favorited_listings_page.dart';
import 'package:alquipet_front/ui/pages/home_page.dart';
import 'package:alquipet_front/ui/pages/listing_page.dart';
import 'package:alquipet_front/ui/pages/listings_user_page.dart';
import 'package:alquipet_front/ui/pages/login_page.dart';
import 'package:alquipet_front/ui/pages/not_found_page.dart';
import 'package:alquipet_front/ui/pages/user_register_page.dart';
import 'package:alquipet_front/ui/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:url_strategy/url_strategy.dart';

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
    Get.put(HomeProvider());
    Get.put(ListingProvider());
    Get.put(LoginProvider());
    Get.put(UserProfileProvider());

    return GetMaterialApp(
      ///TÍTULO
      title: 'Alquipet',

      //TODO: PROBAR A QUITAR ESTA LINEA Y A SUSTITUIR EL SERVICE POR WIDGET CREADOS CON GETX
      scaffoldMessengerKey: NotificationsService.messengerKey,

      /// THEME
      theme: myLightTheme,

      ///ROUTES
      unknownRoute: GetPage(
        name: '/not_found',
        page: () => const NotFoundPage(),
        transition: Transition.noTransition,
      ),
      initialRoute: '/inicio',
      getPages: [
        GetPage(
          name: '/crear_anuncio',
          page: () => const CreateListingPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/anuncios_favoritos',
          page: () => const FavoritedListingsPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/inicio',
          page: () => const HomePage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/anuncio',
          page: () => const ListingPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/mis_anuncios',
          page: () => const ListingsUserPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/usuario',
          page: () => const UserRegisterPage(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/registrar_usuario',
          page: () => const UserRegisterPage(),
          transition: Transition.noTransition,
        ),
      ],
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
//             text: 'IR A PG 2'),
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
//             text: 'IR A HOME'),
//       ),
//     );
//   }
// }
