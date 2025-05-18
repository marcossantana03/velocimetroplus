import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocimetroplus/views/monitor/widget/body_monitoramento.dart';
import '../../blocs/monitoramento/monitoramento_bloc.dart';
import '../../blocs/monitoramento/monitoramento_event.dart';
import '../widget/app_bar_personalizado.dart';

class ScreenMonitor extends StatefulWidget {
  const ScreenMonitor({super.key});

  @override
  State<ScreenMonitor> createState() => _ScreenMonitorState();
}

class _ScreenMonitorState extends State<ScreenMonitor> {
  bool _disparou = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_disparou) {
      context.read<MonitoramentoBloc>().add(IniciarMonitoramento());
      _disparou = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPersonalizado(titulo: 'Monitoramento'),
      body: BodyMonitoramento(),
    );
  }
}
