import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarPersonalizado extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const AppBarPersonalizado({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        titulo,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
