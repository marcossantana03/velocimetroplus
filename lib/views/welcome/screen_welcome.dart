import 'package:flutter/material.dart';
import 'package:velocimetroplus/views/welcome/widgets/body_welcome.dart';
import 'package:velocimetroplus/views/welcome/widgets/bottom_navigator_bar_personalizado.dart';

class ScreenWelcome extends StatelessWidget {
  const ScreenWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWelcome(),
      bottomNavigationBar: BottomNavigatorBarPersonalizado(),
    );
  }
}
