import 'package:alquipet_front/providers/side_menu_provider.dart';
import 'package:alquipet_front/ui/widgets/navbar.dart';
import 'package:alquipet_front/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _DashboardLayoutState createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuProvider>(
      init: SideMenuProvider(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xffEDF1F2),
          body: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (Responsive.isDesktop(context) ||
                      Responsive.isTablet(context))
                    const Sidebar(),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        const Navbar(),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: widget.child,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (Responsive.isMobile(context))
                AnimatedBuilder(
                  animation: SideMenuProvider.menuController,
                  builder: (context, _) => Stack(
                    children: <Widget>[
                      if (SideMenuProvider.isOpen)
                        Opacity(
                          opacity: SideMenuProvider.opacity.value,
                          child: GestureDetector(
                            onTap: () {
                              SideMenuProvider.closeMenu();
                              controller.update();
                            },
                            child: Container(
                              width: Get.width,
                              height: Get.height,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      if (SideMenuProvider.isOpen)
                        Transform.translate(
                          offset: Offset(SideMenuProvider.movement.value, 0),
                          child: const Sidebar(),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
