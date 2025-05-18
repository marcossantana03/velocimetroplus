import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonitoramentoChart extends StatelessWidget {
  final List<Map<String, dynamic>> historico;

  const MonitoramentoChart({super.key, required this.historico});

  List<FlSpot> _gerarSpots(String campo) {
    return historico.asMap().entries
        .where((entry) => entry.value[campo] != null)
        .map((entry) {
      final i = entry.key;
      final valor = (entry.value[campo] as num).toDouble();
      return FlSpot(i.toDouble(), valor);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          backgroundColor: const Color(0xFF121212),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < historico.length) {
                    final data = historico[index]['data'];
                    final dia = DateTime.parse(data).day;
                    return Text(
                      '$dia',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.white24),
              left: BorderSide(color: Colors.white24),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: _gerarSpots('download'),
              isCurved: true,
              barWidth: 3,
              color: Colors.cyanAccent,
              dotData: FlDotData(show: true),
            ),
            LineChartBarData(
              spots: _gerarSpots('upload'),
              isCurved: true,
              barWidth: 3,
              color: Colors.blueAccent,
              dotData: FlDotData(show: true),
            ),
            LineChartBarData(
              spots: _gerarSpots('ping'),
              isCurved: true,
              barWidth: 3,
              color: Colors.grey,
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
