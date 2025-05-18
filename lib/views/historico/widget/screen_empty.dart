import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenEmpty extends StatelessWidget {
  const ScreenEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Sem registros no momento...',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.white70,
            )));
  }
}
