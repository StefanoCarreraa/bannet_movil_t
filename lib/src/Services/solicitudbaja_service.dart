import 'dart:convert';
import 'package:bannet_movil_t/src/Models/solicitudbaja_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class BajaSuspensionService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<Map<String, dynamic>> registrarBajaSuspension(
      BajaSuspensionModel bajaSuspension) async {
    final url = Uri.parse('$baseUrl/api/baja-suspension');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bajaSuspension.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Error en la solicitud: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al registrar la baja de suspensión: $e');
    }
  }
}
