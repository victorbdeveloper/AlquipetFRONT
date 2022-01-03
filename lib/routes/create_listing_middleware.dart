import 'package:alquipet_front/providers/side_menu_provider.dart';
import 'package:get/get.dart';

class CreateListingMiddleware extends GetMiddleware {
  final SideMenuProvider sideMenuProvider = Get.find<SideMenuProvider>();

  @override
  GetPage onPageCalled(GetPage? page) {
    sideMenuProvider.setCurrentPageUrl("/crear_anuncio");
    return page!;
  }
}
