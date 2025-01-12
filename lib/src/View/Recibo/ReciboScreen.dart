import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';

class ReciboScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color blanco = Color(0xFFFFFFFF);
  final Color negro = Color(0xFF000000);

  ReciboScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/logo_bannet_1.png',
            height: 30,
          ),
        ),
        toolbarHeight: 60,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh, color: negro),
          ),
        ],
        backgroundColor: negro,
        centerTitle: true,
        iconTheme: IconThemeData(color: verdeLima),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Bannet_Fond.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Mi recibo Bantel",
                  style: TextStyle(
                    color: verdeLima,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recibo.pdf', // Título del recibo
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed:
                              _downloadRecibo, // Llama a la función de descarga
                          icon: Icon(Icons.download), // Ícono de descarga
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 8), // Espaciado entre el título y el contenedor
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Fondo del contenedor
                        borderRadius:
                            BorderRadius.circular(16), // Esquinas redondeadas
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(
                                0.5), // Sombra blanca semi-transparente
                            blurRadius: 10, // Desenfoque de la sombra
                            offset: Offset(0, 4), // Desplazamiento de la sombra
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            16), // Asegura que el contenido respete las esquinas
                        child: SizedBox(
                          height: 500, // Ajusta la altura según tus necesidades
                          child: SfPdfViewer.asset(
                            'assets/pdfs/Recibo.pdf', // Reemplaza con tu archivo
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Función para descargar el recibo en la carpeta pública Descargas
  Future<void> _downloadRecibo() async {
    try {
      // Solicitar permisos
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception("Permiso de almacenamiento denegado");
      }

      // Cargar el archivo desde los assets
      final byteData = await rootBundle.load('assets/pdfs/Recibo.pdf');

      // Obtener la ruta de la carpeta pública Descargas usando path_provider
      final directory = await getExternalStorageDirectory();
      final downloadsDir = Directory('${directory?.path}/Download');
      if (!downloadsDir.existsSync()) {
        await downloadsDir.create();
      }

      final filePath = '${downloadsDir.path}/Recibo.pdf';

      // Escribir el archivo
      final file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Mostrar notificación al usuario
      print('Archivo descargado en: $filePath');
    } catch (e) {
      print('Error al descargar el archivo: $e');
    }
  }
}
