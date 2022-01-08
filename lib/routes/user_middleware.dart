import "package:alquipet_front/providers/auth_provider.dart";
import "package:alquipet_front/providers/side_menu_provider.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class UserMiddleware extends GetMiddleware {
  final SideMenuProvider sideMenuProvider = Get.find<SideMenuProvider>();

  @override
  GetPage onPageCalled(GetPage? page) {
    sideMenuProvider.setCurrentPageUrl("/usuario");
    return page!;
  }
}
