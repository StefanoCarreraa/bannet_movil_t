import 'dart:convert';
import 'package:bannet_movil_t/src/Models/reciboPendiente_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ReciboService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<List<ReciboPendienteModel>> listarRecibosPendientes(int idPersona) async {
    final url = Uri.parse('$baseUrl/api/recibos-pendientes?IDPersona=$idPersona');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          final List recibos = data['data'];
          return recibos
              .map((recibo) => ReciboPendienteModel.fromJson(recibo))
              .toList();
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Error al obtener los recibos pendientes.');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}
