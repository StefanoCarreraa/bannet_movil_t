import 'dart:io';

import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/AlertshowModalBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';

class Comprobantescreen extends StatefulWidget {
  final List<String> fileName;

  const Comprobantescreen(this.fileName, {super.key});

  @override
  State<Comprobantescreen> createState() => _ComprobantescreenState();
}

class _ComprobantescreenState extends State<Comprobantescreen> {
  Directory? directory;
  String? filePath;
  bool isLoading = true;
  Uint8List? pdfBytes;
  String? path;
  @override
  void initState() {
    super.initState();
    _esperarArchivo();
  }

  Future<void> _esperarArchivo() async {
    Directory directory = await getApplicationDocumentsDirectory();
    path = '${directory.path}/${widget.fileName[1]}';

    int retries = 10;
    while (!File(path!).existsSync() && retries > 0) {
      print("⏳ Esperando que el archivo PDF esté disponible...");
      await Future.delayed(Duration(milliseconds: 500));
      retries--;
    }

    if (File(path!).existsSync()) {
      print("✅ Archivo encontrado: $path");

      // Espera 1 segundo para asegurarse de que el archivo se haya guardado completamente
      await Future.delayed(Duration(seconds: 1));

      File file = File(path!);
      print("📂 Archivo existe: ${file.existsSync()}");
      print("📄 Tamaño del archivo: ${file.lengthSync()} bytes");

      // Cargar el archivo en memoria
      pdfBytes = await file.readAsBytes();

      setState(() {
        filePath = path;
        isLoading = false;
      });
    } else {
      print("❌ No se encontró el archivo después de varios intentos");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
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
                        "Mi Comprobante Bantel",
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
                                widget.fileName[1], // Título del recibo
                                style: TextStyle(
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  _downloadComprobante(context);
                                },
                                icon: Icon(Icons.download),
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  8), // Espaciado entre el título y el contenedor
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Fondo del contenedor
                              borderRadius: BorderRadius.circular(
                                  16), // Esquinas redondeadas
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(
                                      0.5), // Sombra blanca semi-transparente
                                  blurRadius: 10, // Desenfoque de la sombra
                                  offset: Offset(
                                      0, 4), // Desplazamiento de la sombra
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16), // Asegura que el contenido respete las esquinas
                              child: SizedBox(
                                height:
                                    500, // Ajusta la altura según tus necesidades
                                child: pdfBytes != null
                                    ? SfPdfViewer.memory(
                                        pdfBytes!) // Muestra el PDF si se encuentra
                                    : Center(
                                        child: Text(
                                            "Error: No se pudo cargar el PDF")),
                                // SfPdfViewer.asset(filePath),
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

  /// Función para descargar el comprobante en la carpeta pública Descargas
  Future<void> _downloadComprobante(BuildContext context) async {
    try {
      PermissionStatus status =
          await Permission.manageExternalStorage.request();

      if (status.isGranted) {
      } else if (status.isDenied) {
        print("Permiso denegado");
        return;
      } else if (status.isPermanentlyDenied) {
        print("Permiso denegado");
        return;
      }

      File sourceFile = File(filePath!);
      if (!await sourceFile.exists()) {
        print("❌ El archivo no existe en la ruta: $filePath");
        return;
      }

      Directory downloadsDir = Directory('/storage/emulated/0/Download');

      if (!downloadsDir.existsSync()) {
        await downloadsDir.create(recursive: true);
      }

      String fileName = filePath!.split('/').last;
      String destinationPath = '${downloadsDir.path}/$fileName';

      await sourceFile.copy(destinationPath);
      _mostrarDialogoDescargaExitosa(context, destinationPath);

      print("✅ Archivo copiado en: $destinationPath");
    } catch (e) {
      mostrarNotificacion(
        context: context,
        titulo: 'Error de Descarga',
        mensaje: "Error al descargar el archivo: $e",
      );
      print("❌ Error al descargar el archivo: $e");
    }
  }

  void _mostrarDialogoDescargaExitosa(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Descarga Completa"),
          content: Text(
              "El archivo se ha guardado en:\n$filePath\n\n¿Desea abrirlo ahora?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _abrirArchivo(filePath);
              },
              child: Text("Abrir"),
            ),
          ],
        );
      },
    );
  }
}

void _abrirArchivo(String filePath) async {
  try {
    OpenResult result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      print("❌ Error al abrir el archivo: ${result.message}");
    }
  } catch (e) {
    print("❌ No se pudo abrir el archivo: $e");
  }
}
