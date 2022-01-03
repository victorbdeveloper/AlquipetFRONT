import 'package:alquipet_front/providers/side_menu_provider.dart';
import 'package:get/get.dart';

class HomeMiddleware extends GetMiddleware {
  final SideMenuProvider sideMenuProvider = Get.find<SideMenuProvider>();

  @override
  GetPage onPageCalled(GetPage? page) {
    sideMenuProvider.setCurrentPageUrl("/inicio");
    return page!;
  }
}
