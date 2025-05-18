import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../blocs/monitoramento/monitoramento_bloc.dart';
import '../../../blocs/monitoramento/monitoramento_event.dart';
import '../../../blocs/monitoramento/monitoramento_state.dart';
import 'botao_historico.dart';
import 'botao_monitoramento.dart';
import 'info_boxes.dart';
import 'loader_monitoramento.dart';

class BodyMonitoramento extends StatelessWidget {
  static const double horizontal = 0.06;
  static const double defaultSpacing = 0.03;
  static const double small = 0.02;

  const BodyMonitoramento({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largura = constraints.maxWidth;
        final altura = constraints.maxHeight;
        final gaugeSize = largura < 400 ? largura * 0.6 : largura * 0.7;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: altura),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: largura * horizontal),
                child: BlocBuilder<MonitoramentoBloc, MonitoramentoState>(
                  builder: (context, state) {
                    if (state is MonitoramentoEmExecucao &&
                        state.mensagem.toLowerCase().contains('erro') &&
                        state.download == null &&
                        state.upload == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Erro ao testar a conexão. Verifique sua internet.',
                            style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      });
                    }
                    final exec = state is MonitoramentoEmExecucao ? state : null;
                    final isExecutando = state is MonitoramentoEmExecucao;
                    final downloadValue = exec?.download;
                    final uploadValue = exec?.upload;
                    final mensagem = exec?.mensagem ?? 'Monitoramento parado';
                    final emProgresso = exec?.emProgresso ?? false;
                    final isUploadPhase = exec?.mensagem.toLowerCase().contains('enviando') ?? false;
                    final isParado = state is MonitoramentoPausado;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: altura * small),
                        Text(
                          mensagem,
                          style: GoogleFonts.roboto(
                            fontSize: largura * 0.04,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(height: altura * defaultSpacing),
                        Center(
                          child: LoaderMonitoramento(
                            gaugeSize: gaugeSize,
                            downloadValue: downloadValue,
                            uploadValue: uploadValue,
                            isParado: isParado,
                            isExecutando: isExecutando,
                            emProgresso: emProgresso,
                            isUploadPhase: isUploadPhase,
                          ),
                        ),
                        SizedBox(height: altura * defaultSpacing),
                        BotaoMonitoramento(
                          isParado: isParado,
                          altura: altura,
                          largura: largura,
                          onPressed: () {
                            context.read<MonitoramentoBloc>().add(
                              isParado ? IniciarMonitoramento() : PararMonitoramento(),
                            );
                          },
                        ),
                        SizedBox(height: altura * small),
                        InfoBoxes(
                          download: downloadValue?.toStringAsFixed(1) ?? '-',
                          upload: uploadValue?.toStringAsFixed(1) ?? '-',
                          altura: altura,
                        ),
                        const SizedBox(height: 12),
                        BotaoVerHistorico(largura: largura, altura: altura),
                        SizedBox(height: altura * defaultSpacing),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
