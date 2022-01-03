import 'package:alquipet_front/ui/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class CreateListingPage extends StatelessWidget {
  const CreateListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: Text("CREATE LISTING"),
    );
  }
}
