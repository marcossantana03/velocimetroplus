import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BodyWelcome extends StatelessWidget {
  const BodyWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/rocket.json',
              width: 200,
              height: 200,
              repeat: true,
            ),
            const SizedBox(height: 40),
            Text(
              'INICIAR\nMONITORAMENTO',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 23,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
