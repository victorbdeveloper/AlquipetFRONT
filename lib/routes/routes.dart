import 'package:alquipet_front/routes/auth_middleware.dart';
import 'package:alquipet_front/ui/pages/create_listing_page.dart';
import 'package:alquipet_front/ui/pages/favorited_listings_page.dart';
import 'package:alquipet_front/ui/pages/home_page.dart';
import 'package:alquipet_front/ui/pages/listing_page.dart';
import 'package:alquipet_front/ui/pages/listings_user_page.dart';
import 'package:alquipet_front/ui/pages/login_page.dart';
import 'package:alquipet_front/ui/pages/user_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

List<GetPage<dynamic>> routes() {
  return <GetPage>[
    GetPage(
      name: '/crear_anuncio',
      page: () => const CreateListingPage(),
      transition: Transition.noTransition,
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/anuncios_favoritos',
      page: () => const FavoritedListingsPage(),
      transition: Transition.noTransition,
      middlewares: [AuthMiddleware()],
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
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/usuario',
      page: () => const UserPage(),
      transition: Transition.noTransition,
      middlewares: [AuthMiddleware()],
    ),
  ];
}
