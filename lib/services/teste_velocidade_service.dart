import 'dart:async';
import 'package:flutter_speed_test_plus/flutter_speed_test_plus.dart';
import 'historico_service.dart';

class TesteDeVelocidadeService {
  static Future<void> testeEGravaHistorico() async {
    final FlutterInternetSpeedTest speedTest = FlutterInternetSpeedTest();
    final completer = Completer<void>();

    try {
      await speedTest.startTesting(
        useFastApi: true,
        onCompleted: (downloadResult, uploadResult) async {
          final now = DateTime.now();
          final resultado = {
            'data': now.toIso8601String(),
            'download': downloadResult.transferRate,
            'upload': uploadResult.transferRate,
            'ping': 0,
          };
          await HistoricoService.salvarResultado(resultado);
          completer.complete();
        },
        onError: (msg, error) {
          if (!completer.isCompleted) completer.complete();
        },
        onCancel: () {
          if (!completer.isCompleted) completer.complete();
        },
      );
      await completer.future;
    } catch (e) {
      print('$e');
    }
  }
}
