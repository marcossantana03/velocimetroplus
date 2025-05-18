import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoMonitoramento extends StatelessWidget {
  final bool isParado;
  final double altura;
  final double largura;
  final VoidCallback onPressed;

  const BotaoMonitoramento({
    super.key,
    required this.isParado,
    required this.altura,
    required this.largura,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1F1F1F),
          padding: EdgeInsets.symmetric(vertical: altura * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          isParado ? Icons.play_arrow : Icons.pause,
          color: Colors.white,
        ),
        label: Text(
          isParado ? 'Iniciar novamente' : 'Parar',
          style: GoogleFonts.roboto(
            fontSize: largura * 0.04,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
