import "package:alquipet_front/ui/layouts/dashboard_layout.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16.0),
            child: Text(
              "404 - Página no encontrada",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserratAlternates(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Text(
          "404 - Página no encontrada",
          style: GoogleFonts.montserratAlternates(
              fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
