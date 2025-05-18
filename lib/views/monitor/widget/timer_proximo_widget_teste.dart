import 'package:flutter/material.dart';
import 'dart:async';

class TimerProximoWidgetTeste extends StatefulWidget {
  const TimerProximoWidgetTeste({super.key});

  @override
  State<TimerProximoWidgetTeste> createState() => _TimerProximoWidgetTesteState();
}

class _TimerProximoWidgetTesteState extends State<TimerProximoWidgetTeste> {
  late int segundosRestantes;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    segundosRestantes = 120;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (segundosRestantes > 0) {
            segundosRestantes--;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutos = (segundosRestantes ~/ 60).toString().padLeft(2, '0');
    final segundos = (segundosRestantes % 60).toString().padLeft(2, '0');
    return Column(
      children: [
        Text(
          'Próximo teste em:',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          '$minutos:$segundos',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.cyanAccent,
          ),
        ),
      ],
    );
  }
}
