import "package:alquipet_front/providers/side_menu_provider.dart";
import "package:get/get.dart";

class FavoriteListingMiddleware extends GetMiddleware {
  final SideMenuProvider sideMenuProvider = Get.find<SideMenuProvider>();

  @override
  GetPage onPageCalled(GetPage? page) {
    sideMenuProvider.setCurrentPageUrl("/anuncios_favoritos");
    return page!;
  }
}
