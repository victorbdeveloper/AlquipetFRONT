import 'package:alquipet_front/providers/side_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuProvider>(
      init: SideMenuProvider(),
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: 50,
          decoration: buildBoxDecoration(),
          child: Row(
            children: <Widget>[
              if (Responsive.isMobile(context))
                IconButton(
                    icon: const Icon(Icons.menu_outlined),
                    iconSize: 25,
                    onPressed: () {
                      SideMenuProvider.openMenu();
                      controller.update();
                    }),
              const Expanded(
                child: Center(
                  child: Text(
                    "ALQUIPET",
                  ),
                ),
              ),
              if (Responsive.isMobile(context))
                const SizedBox(
                  width: 25,
                )
            ],
          ),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
