import "package:alquipet_front/ui/layouts/dashboard_layout.dart";
import "package:flutter/material.dart";

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: Text("USER PAGE"),
    );
  }
}
