import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SquareIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  const SquareIcon(
      {super.key,
        required this.icon,
        required this.label,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Column(children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 5),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Icon(
              icon,
              size: 100,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              // Taille de la police
              fontWeight: FontWeight.bold,
              // Poids de la police (normal, bold, etc.)
              fontStyle:
              FontStyle.normal, // Style de la police (normal, italic)
              // Vous pouvez également définir d'autres propriétés de style ici
            ),
          ),
        ]));
  }
}
