import 'dart:convert';
import 'dart:io';
import 'package:bannet_movil_t/src/Models/comprobanteImpresion_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfDescargarService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<List<String?>> DescargarPdfComprobante(
      List<ComprobanteImpresionModel> reciboimpresionModel) async {
    final url = Uri.parse('$baseUrl/api/generar-pdf-comprobantes');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reciboimpresionModel.map((e) => e.toJson()).toList()),
      );

      if (response.statusCode == 200) {
        // Obtener la fecha actual y formatearla
        final DateTime now = DateTime.now();
        final String? numDocumento = reciboimpresionModel.first.nroDocumento;
        final String formattedDate =
            "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
        final String fileName = '${numDocumento}_$formattedDate.pdf';

        // Obtener el directorio de almacenamiento interno
        final Directory? directory = await getApplicationDocumentsDirectory();
        if (directory == null) {
          print("Error: No se pudo acceder al directorio");
          return [];
        }

        final String filePath = '${directory.path}/$fileName';

        // Guardar el archivo en almacenamiento interno
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print("Archivo guardado en: $filePath");
        return [filePath, fileName]; // Devolver la ruta del archivo guardado
      } else {
        throw Exception("Error al descargar el PDF");
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
