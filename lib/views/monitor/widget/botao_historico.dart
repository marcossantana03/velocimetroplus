import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoVerHistorico extends StatelessWidget {
  final double altura;
  final double largura;

  const BotaoVerHistorico({super.key, required this.altura, required this.largura});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.push('/historico'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1F1F1F),
          padding: EdgeInsets.symmetric(vertical: altura * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Ver Histórico',
          style: GoogleFonts.roboto(
            fontSize: largura * 0.04,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
