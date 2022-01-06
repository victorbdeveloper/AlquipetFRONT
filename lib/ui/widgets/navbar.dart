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
                    color: const Color(0xff092044),
                    onPressed: () {
                      SideMenuProvider.openMenu();
                      controller.update();
                    }),
              Expanded(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'ALQUIPET',
                        style: TextStyle(
                          fontSize: 40,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.blue[700]!,
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        'ALQUIPET',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
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
        color: Colors.blue,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 5),
        ],
      );
}
