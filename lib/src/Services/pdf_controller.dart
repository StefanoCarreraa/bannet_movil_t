import 'dart:convert';
import 'dart:io';
import 'package:bannet_movil_t/src/Models/reciboImpresion_model%20.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class PdfDownloader {
  final String baseUrl = AppCconfig.baseUrl;

  Future<String?> downloadAndOpenPdf(
      List<ReciboimpresionModel> reciboimpresionModel) async {
    final url = Uri.parse('$baseUrl/api/generar-pdf');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reciboimpresionModel.map((e) => e.toJson()).toList()),
      );

      if (response.statusCode == 200) {
        // Obtener la fecha actual y formatearla
        final DateTime now = DateTime.now();

        // Obtener el número de documento
        final String numDocumento = reciboimpresionModel.first.numDocumento;

        final String formattedDate =
            "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
        // Obtener la ubicación para guardar el archivo
        final String fileName = '${numDocumento}_$formattedDate.pdf';

        final file = File('assets/pdfs/$fileName');

        // Escribir el contenido del PDF
        await file.writeAsBytes(response.bodyBytes);
        return fileName;
      } else {
        throw Exception("Error al descargar el PDF");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
