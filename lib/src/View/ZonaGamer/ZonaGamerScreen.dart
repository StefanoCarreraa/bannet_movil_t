import 'package:flutter/material.dart';

class ZonaGamerScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color grisFondo = Color(0xFFF5F5F5);
  final Color grisOscuro = Color(0xFF333333);
  final Color negro = Color(0xFF000000);

  ZonaGamerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // Fondo blanco
      appBar: AppBar(
        title:
            Text('Zona Gamer', style: TextStyle(color: Colors.black87)),
        backgroundColor: verdeLima, // Verde lima
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
    );
  }
}
