import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocimetroplus/views/historico/widget/body_historico.dart';
import 'package:velocimetroplus/views/historico/widget/screen_empty.dart';

import '../widget/app_bar_personalizado.dart';

class ScreenHistorico extends StatefulWidget {
  const ScreenHistorico({super.key});

  @override
  State<ScreenHistorico> createState() => _ScreenHistoricoState();
}

class _ScreenHistoricoState extends State<ScreenHistorico> {
  List<Map<String, dynamic>> historico = [];

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  Future<void> carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('historico') ?? [];
    final dados = lista
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList()
      ..sort((a, b) => b['data'].compareTo(a['data']));

    setState(() {
      historico = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBarPersonalizado(titulo: 'Histórico',),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: historico.isEmpty
            ? const ScreenEmpty()
            : BodyHistorico(historico: historico),
      ),
    );
  }
}
