import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSeparator extends StatelessWidget {
  final IconData iconData;
  final String text;

  const TextSeparator({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(iconData, color: Colors.white.withOpacity(0.3)),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.roboto(
                color: Colors.white.withOpacity(0.3), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
