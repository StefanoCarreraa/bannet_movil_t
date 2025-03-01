import 'dart:convert';
import 'package:bannet_movil_t/src/Models/comprobanteImpresion_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ComprobanteImpresionService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<List<ComprobanteImpresionModel>> getComprobantesImpresion(
      int idDocVenta) async {
    final url = Uri.parse(
        '$baseUrl/api/comprobantes-impresion?ID_DOCVENTA=$idDocVenta');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          final List<dynamic> comprobantesList = data['data'];

          return comprobantesList
              .map((comprobante) =>
                  ComprobanteImpresionModel.fromJson(comprobante))
              .toList();
        } else {
          throw Exception(data['message']);
        }
      } else {
        pragma('Error al obtener los comprobantes pendientes de impresión (Código ${response.statusCode})');
        throw Exception(
            'Error al obtener los comprobantes pendientes de impresión (Código ${response.statusCode})');
      }
    } catch (e) {
      pragma('Error al conectar con el servidor: $e');
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}
