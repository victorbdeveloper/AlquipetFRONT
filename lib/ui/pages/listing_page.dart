import 'package:alquipet_front/ui/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: Text("LISTING PAGE"),
    );
  }
}
