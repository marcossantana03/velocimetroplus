import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Legend extends StatelessWidget {
  final IconData icon;
  final String label;

  const Legend({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyanAccent, size: 23),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
