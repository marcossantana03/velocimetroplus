import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocimetroplus/views/historico/widget/item_historico_card.dart';
import 'package:velocimetroplus/views/historico/widget/legend.dart';
import 'package:velocimetroplus/views/historico/widget/monitoramento_chart.dart';

class BodyHistorico extends StatelessWidget {
  final List<Map<String, dynamic>> historico;

  const BodyHistorico({super.key, required this.historico});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Últimos ${historico.length} registros',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Monitoramento',
          style: GoogleFonts.roboto(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        MonitoramentoChart(historico: historico),
        const SizedBox(height: 16),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Legend(icon: Icons.arrow_downward, label: 'Download'),
            SizedBox(height: 8),
            Legend(icon: Icons.arrow_upward, label: 'Upload'),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Registros',
          style: GoogleFonts.roboto(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...historico.map((item) => ItemHistoricoCard(item: item)),
      ],
    );
  }
}
