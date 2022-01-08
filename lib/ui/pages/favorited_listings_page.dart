import "package:alquipet_front/ui/layouts/dashboard_layout.dart";
import "package:flutter/material.dart";

class FavoritedListingsPage extends StatelessWidget {
  const FavoritedListingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: Text("FAVORITED LISTINGS"),
    );
  }
}
