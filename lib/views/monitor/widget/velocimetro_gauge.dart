import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VelocimetroGauge extends StatelessWidget {
  final double? download;
  final double? upload;
  final double largura;
  final bool isUpload;

  const VelocimetroGauge({
    super.key,
    this.download,
    this.upload,
    required this.largura,
    this.isUpload = false,
  });

  double calcularMaxValue(double? valor, {bool isUpload = false}) {
    if (valor == null) return isUpload ? 100 : 200;
    final base = isUpload ? 50 : 100;
    double max = ((valor / base).ceil() * base).toDouble();
    if (max < (isUpload ? 100 : 200)) max = isUpload ? 100 : 200;
    return max;
  }

  @override
  Widget build(BuildContext context) {
    final value = isUpload ? upload : download;
    final label = isUpload ? 'Upload' : 'Download';
    final maxValue = calcularMaxValue(value, isUpload: isUpload);

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: maxValue,
          interval: maxValue / 5,
          showTicks: true,
          showLabels: true,
          axisLabelStyle: GaugeTextStyle(
            color: Colors.white70,
            fontSize: largura * 0.03,
          ),
          axisLineStyle: const AxisLineStyle(
            thickness: 0.15,
            thicknessUnit: GaugeSizeUnit.factor,
            cornerStyle: CornerStyle.bothFlat,
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: maxValue * 0.33,
              color: Colors.cyan.shade200,
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            GaugeRange(
              startValue: maxValue * 0.33,
              endValue: maxValue * 0.66,
              color: Colors.cyan,
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            GaugeRange(
              startValue: maxValue * 0.66,
              endValue: maxValue,
              color: Colors.blueAccent,
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: value ?? 0,
              enableAnimation: true,
              needleColor: Colors.white,
              knobStyle: const KnobStyle(color: Colors.white),
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.roboto(
                      fontSize: largura * 0.04,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    value == null ? '-' : '${value.toStringAsFixed(1)} Mbps',
                    style: GoogleFonts.roboto(
                      fontSize: largura * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              angle: 90,
              positionFactor: 0.5,
            )
          ],
        ),
      ],
    );
  }
}
