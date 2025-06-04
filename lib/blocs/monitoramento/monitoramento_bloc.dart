import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../services/historico_service.dart';
import 'monitoramento_event.dart';
import 'monitoramento_state.dart';
import 'package:flutter_speed_test_plus/flutter_speed_test_plus.dart';

class MonitoramentoBloc extends Bloc<MonitoramentoEvent, MonitoramentoState> {
  final FlutterInternetSpeedTest _speedTest = FlutterInternetSpeedTest();
  Timer? _timer;

  MonitoramentoBloc() : super(MonitoramentoInicial()) {
    on<IniciarMonitoramento>(_onIniciar);
    on<PararMonitoramento>(_onParar);
    on<ResultadoRecebido>(_onResultadoRecebido);
  }

  Future<void> _onIniciar(IniciarMonitoramento event, Emitter<MonitoramentoState> emit) async {
    emit(MonitoramentoEmExecucao(
      download: null,
      upload: null,
      emProgresso: true,
      mensagem: 'Iniciando teste de conexão...',
    ));

    _startSpeedTest();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 2), (_) {
      _startSpeedTest();
    });
  }

  void _onParar(PararMonitoramento event, Emitter<MonitoramentoState> emit) async {
    _timer?.cancel();

    final currentState = state;
    final download = currentState is MonitoramentoEmExecucao ? currentState.download : null;
    final upload = currentState is MonitoramentoEmExecucao ? currentState.upload : null;

    emit(MonitoramentoPausado(
      download: download,
      upload: upload,
      mensagem: 'Monitoramento pausado',
    ));

    if (_speedTest.isTestInProgress()) {
      await _speedTest.cancelTest();
    }
  }

  void _onResultadoRecebido(ResultadoRecebido event, Emitter<MonitoramentoState> emit) {
    emit(MonitoramentoEmExecucao(
      download: event.download,
      upload: event.upload,
      emProgresso: event.emProgresso,
      mensagem: event.mensagem,
    ));
  }

  Future<void> _startSpeedTest() async {
    final temConexao = await _verificarConectividade();
    if (!temConexao) {
      _emitirResultadoErro('Sem conexão com a internet.');
      return;
    }

    if (_speedTest.isTestInProgress()) {
      await _speedTest.cancelTest();
    }

    _iniciarTesteVelocidade();
  }

  Future<bool> _verificarConectividade() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void _emitirResultadoErro(String mensagem) {
    add(ResultadoRecebido(
      download: null,
      upload: null,
      emProgresso: false,
      mensagem: mensagem,
    ));
  }

  void _emitirEstadoIntermediario({
    double? download,
    double? upload,
    required bool emProgresso,
    required String mensagem,
  }) {
    add(ResultadoRecebido(
      download: download,
      upload: upload,
      emProgresso: emProgresso,
      mensagem: mensagem,
    ));
  }

  void _iniciarTesteVelocidade() {
    _speedTest.startTesting(
      useFastApi: true,
      onStarted: () {
        _emitirEstadoIntermediario(
          emProgresso: true,
          mensagem: 'Iniciando teste de conexão...',
        );
      },
      onProgress: (percent, data) {
        _emitirEstadoIntermediario(
          download: data.transferRate,
          upload: null,
          emProgresso: true,
          mensagem: 'Baixando... ${percent.toStringAsFixed(0)}%',
        );
      },
      onDownloadComplete: (data) {
        _emitirEstadoIntermediario(
          download: data.transferRate,
          upload: null,
          emProgresso: true,
          mensagem: 'Testando upload...',
        );
      },
      onUploadComplete: (data) {
        _emitirEstadoIntermediario(
          download: state is MonitoramentoEmExecucao
              ? (state as MonitoramentoEmExecucao).download
              : null,
          upload: data.transferRate,
          emProgresso: true,
          mensagem: 'Finalizando teste...',
        );
      },
      onCompleted: (download, upload) async {
        _emitirEstadoIntermediario(
          download: download.transferRate,
          upload: upload.transferRate,
          emProgresso: false,
          mensagem: 'Teste concluído!',
        );

        await HistoricoService.salvarResultado({
          'data': DateTime.now().toIso8601String(),
          'download': download.transferRate,
          'upload': upload.transferRate,
          'ping': 0,
        });
      },
      onError: (msg, error) {
        _emitirResultadoErro('Erro: $msg');
      },
      onCancel: () => print('Cancelado'),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}