import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'velocimetro_gauge.dart';
import 'timer_proximo_widget_teste.dart';

class LoaderMonitoramento extends StatelessWidget {
  final double gaugeSize;
  final double? downloadValue;
  final double? uploadValue;
  final bool isParado;
  final bool isExecutando;
  final bool emProgresso;
  final bool isUploadPhase;

  const LoaderMonitoramento({
    super.key,
    required this.gaugeSize,
    required this.downloadValue,
    required this.uploadValue,
    required this.isParado,
    required this.isExecutando,
    required this.emProgresso,
    required this.isUploadPhase,
  });

  @override
  Widget build(BuildContext context) {
    if (isParado) {
      return Image.asset(
        'assets/image/internet.png',
        width: gaugeSize,
        height: gaugeSize,
        fit: BoxFit.contain,
      );
    }
    if (isExecutando && emProgresso) {
      return VelocimetroGauge(
        download: isUploadPhase ? null : downloadValue,
        upload: isUploadPhase ? uploadValue : null,
        largura: gaugeSize,
        isUpload: isUploadPhase,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/wait.json',
          width: gaugeSize,
          height: gaugeSize,
          repeat: true,
        ),
        const SizedBox(height: 16),
        const TimerProximoWidgetTeste(),
      ],
    );
  }
}
