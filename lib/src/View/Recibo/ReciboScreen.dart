import 'dart:io';

import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/AlertshowModalBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';

class ReciboScreen extends StatelessWidget {
  const ReciboScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blanco,
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/logo_miportal.png',
            height: 55,
          ),
        ),
        toolbarHeight: 60,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh, color: AppColors.negro),
          ),
        ],
        backgroundColor: AppColors.negro,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.verdeLima),
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
                    color: AppColors.verdeLima,
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
                          onPressed: () async {
                            _downloadRecibo(context);
                          },
                          icon: Icon(Icons.download),
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
  Future<void> _downloadRecibo(BuildContext context) async {
    try {
      // Solicitar permiso de almacenamiento
      PermissionStatus status =
          await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        // El permiso fue concedido
      } else if (status.isDenied) {
        print("Permiso denegado");
        return;
      } else if (status.isPermanentlyDenied) {
        print("Permiso denegado");
        return;
      }

      // Cargar el archivo desde los assets
      final byteData = await rootBundle.load('assets/pdfs/Recibo.pdf');

      // Obtener la ruta de la carpeta pública de Descargas
      final downloadsDir = Directory('/storage/emulated/0/Download');

      // Crear la carpeta si no existe
      if (!downloadsDir.existsSync()) {
        await downloadsDir.create(recursive: true);
      }

      final filePath = '${downloadsDir.path}/Recibo.pdf';

      // Escribir el archivo
      final file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Mostrar notificación al usuario
      mostrarNotificacion(
        context: context,
        titulo: 'Descarga Completa',
        mensaje: "Archivo descargado en: $filePath",
      );
    } catch (e) {
      // Mostrar notificación al usuario
      mostrarNotificacion(
        context: context,
        titulo: 'Error de Descarga',
        mensaje: "Error al descargar el archivo: $e",
      );
    }
  }
}
