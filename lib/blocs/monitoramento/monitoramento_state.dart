abstract class MonitoramentoState {
  final String mensagem;
  const MonitoramentoState({this.mensagem = ''});
}

class MonitoramentoInicial extends MonitoramentoState {}

class MonitoramentoEmExecucao extends MonitoramentoState {
  final double? download;
  final double? upload;
  final bool emProgresso;

  const MonitoramentoEmExecucao({
    required this.download,
    required this.upload,
    required this.emProgresso,
    super.mensagem,
  });
}

class MonitoramentoPausado extends MonitoramentoState {
  final double? download;
  final double? upload;

  const MonitoramentoPausado({
    required this.download,
    required this.upload,
    super.mensagem = 'Monitoramento pausado',
  });
}

class MonitoramentoErro extends MonitoramentoState {
  const MonitoramentoErro(String mensagem) : super(mensagem: mensagem);
}
