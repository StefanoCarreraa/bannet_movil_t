import 'dart:convert';
import 'package:bannet_movil_t/src/Models/reciboImpresion_model%20.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ReciboImpresionService {
  final String baseUrl = AppCconfig.baseUrl;


  Future<List<ReciboimpresionModel>> getRecibosPendientesImpresion(int idDocCobrar) async {
    final url = Uri.parse('$baseUrl/api/recibos-pendientes-impresion?ID_DOC_COBRAR=$idDocCobrar');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          final List<dynamic> recibosList = data['data'];

          return recibosList.map((recibo) => ReciboimpresionModel.fromJson(recibo)).toList();
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Error al obtener los recibos pendientes de impresión (Código ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}
