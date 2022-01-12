import "package:flutter/material.dart";
import "package:get/get.dart";

class SideMenuProvider extends GetxController
    with GetSingleTickerProviderStateMixin {
  static late AnimationController menuController;
  static bool isOpen = false;

  String _currentPage = "/";

  @override
  void onInit() {
    super.onInit();
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    // //TODO: ELIMINAR EL ADD LISTENER AL ACABAR!
    // SideMenuProvider.menuController.addListener(() => print(
    //     "Animation Controller value: ${SideMenuProvider.menuController.value}"));
  }

  String get currentPage {
    return _currentPage;
  }

  void setCurrentPageUrl(String routeName) {
    _currentPage = routeName;
    Future.delayed(const Duration(milliseconds: 300), () {
      update();
    });
  }

  static Animation<double> movement = Tween<double>(begin: -200, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() {
    isOpen = true;
    menuController.forward();
  }

  static void closeMenu() {
    isOpen = false;
    menuController.reverse();
  }
}
