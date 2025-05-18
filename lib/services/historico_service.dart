import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoricoService {
  static const _key = 'historico';

  static Future<void> salvarResultado(Map<String, dynamic> resultado) async {
    final prefs = await SharedPreferences.getInstance();
    final historico = prefs.getStringList(_key) ?? [];
    historico.insert(0, jsonEncode(resultado));
    if (historico.length > 50) {
      historico.removeRange(50, historico.length);
    }
    await prefs.setStringList(_key, historico);
  }
}
