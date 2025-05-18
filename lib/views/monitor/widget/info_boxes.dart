import 'package:flutter/material.dart';
import 'package:velocimetroplus/views/monitor/widget/info_box.dart';

class InfoBoxes extends StatelessWidget {
  final String download;
  final String upload;
  final double altura;

  const InfoBoxes({
    super.key,
    required this.download,
    required this.upload,
    required this.altura,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InfoBox(
                label: 'Download',
                value: download,
                unit: 'Mbps',
                icon: Icons.arrow_downward,
                iconColor: Colors.cyanAccent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoBox(
                label: 'Upload',
                value: upload,
                unit: 'Mbps',
                icon: Icons.arrow_upward,
                iconColor: Colors.cyanAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: altura * 0.02),
      ],
    );
  }
}
