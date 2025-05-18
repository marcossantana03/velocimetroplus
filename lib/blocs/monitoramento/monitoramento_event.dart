abstract class MonitoramentoEvent {}

class IniciarMonitoramento extends MonitoramentoEvent {}

class PararMonitoramento extends MonitoramentoEvent {}

class ResultadoRecebido extends MonitoramentoEvent {
  final double? download;
  final double? upload;
  final bool emProgresso;
  final String mensagem;

  ResultadoRecebido({this.download, this.upload, required this.emProgresso, required this.mensagem});
}

