import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemHistoricoCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemHistoricoCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final data = DateTime.parse(item['data']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabelValue('Data:', '${data.day}/${data.month} ${data.hour}:${data.minute.toString().padLeft(2, '0')}'),
          const SizedBox(height: 8),
          _buildLabelValue('Download:', '${item['download']} Mbps'),
          const SizedBox(height: 8),
          _buildLabelValue('Upload:', '${item['upload']} Mbps'),
        ],
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
