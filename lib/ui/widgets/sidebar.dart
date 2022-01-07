import 'package:alquipet_front/providers/auth_provider.dart';
import 'package:alquipet_front/providers/side_menu_provider.dart';
import 'package:alquipet_front/ui/buttons/custom_outlined_button.dart';
import 'package:alquipet_front/ui/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'menu_item.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Get.find<SideMenuProvider>();
    final authProvider = Get.find<AuthProvider>();

    return GetBuilder<AuthProvider>(
        init: AuthProvider(),
        builder: (controller) {
          return Container(
            width: 200,
            height: double.infinity,
            decoration: buildBoxDecoration(),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Center(
                    child: authProvider.authStatus != AuthStatus.authenticated
                        ? CustomOutlinedButton(
                            onPressed: () {
                              Get.toNamed("/login");
                            },
                            text: 'LOGIN',
                          )
                        : CustomOutlinedButton(
                            onPressed: () {
                              authProvider.logout();
                            },
                            text: 'LOGOUT',
                          ),
                  ),
                ),
                const TextSeparator(iconData: Icons.home, text: 'Home'),
                MenuItem(
                  text: 'Inicio',
                  onPressed: () {
                    if (sideMenuProvider.currentPage != "/") {
                      Get.toNamed("/");
                      sideMenuProvider.setCurrentPageUrl("/");
                    }
                  },
                  isActive: sideMenuProvider.currentPage == "/",
                ),
                // MenuItem(
                //   text: 'TEST',
                //   onPressed: () {
                //     if (sideMenuProvider.currentPage != "/anuncio") {
                //       Get.toNamed("/anuncio");
                //     }
                //   },
                //   isActive: sideMenuProvider.currentPage == "/anuncio",
                // ),
                if (authProvider.authStatus == AuthStatus.authenticated)
                  Column(
                    children: <Widget>[
                      const TextSeparator(
                          iconData: Icons.account_circle, text: 'Usuario'),
                      MenuItem(
                        text: 'Perfil',
                        onPressed: () {
                          if (sideMenuProvider.currentPage != "/usuario") {
                            Get.toNamed("/usuario");
                          }
                        },
                        isActive: sideMenuProvider.currentPage == "/usuario",
                      ),
                      const TextSeparator(
                          iconData: Icons.list_alt,
                          text: 'Gestión de anuncios'),
                      MenuItem(
                        text: 'Crear anuncio',
                        onPressed: () {
                          if (sideMenuProvider.currentPage !=
                              "/crear_anuncio") {
                            Get.toNamed("/crear_anuncio");
                          }
                        },
                        isActive:
                            sideMenuProvider.currentPage == "/crear_anuncio",
                      ),
                      MenuItem(
                        text: 'Mis anuncios',
                        onPressed: () {
                          if (sideMenuProvider.currentPage != "/mis_anuncios") {
                            Get.toNamed("/mis_anuncios");
                          }
                        },
                        isActive:
                            sideMenuProvider.currentPage == "/mis_anuncios",
                      ),
                      MenuItem(
                        text: 'Favoritos',
                        onPressed: () {
                          if (sideMenuProvider.currentPage !=
                              "/anuncios_favoritos") {
                            Get.toNamed("/anuncios_favoritos");
                          }
                        },
                        isActive: sideMenuProvider.currentPage ==
                            "/anuncios_favoritos",
                      )
                    ],
                  ),
              ],
            ),
          );
        });
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xff092044),
            Color(0xff092042),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black26, blurRadius: 10),
        ],
      );
}
