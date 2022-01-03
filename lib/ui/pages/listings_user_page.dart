import 'package:alquipet_front/providers/side_menu_provider.dart';
import 'package:alquipet_front/ui/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListingsUserPage extends StatelessWidget {
  const ListingsUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: Text("LISTING USER_PAGE"),
    );
  }
}
