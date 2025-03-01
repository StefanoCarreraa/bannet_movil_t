import 'dart:convert';
import 'package:bannet_movil_t/src/Models/comprobante_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ComprobanteService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<List<ComprobanteModel>> listarComprobantes(int idPersona) async {
    final url = Uri.parse('$baseUrl/api/comprobantes?IDPersona=$idPersona');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          final List comprobantes = data['data'];
         return comprobantes
              .map((comprobante) => ComprobanteModel.fromJson(comprobante))
              .toList();
              
        } else {
          throw Exception(data['message']);
        }
      } 
      else {
        throw Exception('Error al obtener los comprobantes pendientes.');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}
