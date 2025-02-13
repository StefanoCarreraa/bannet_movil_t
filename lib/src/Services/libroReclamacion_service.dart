import 'dart:convert';
import 'package:bannet_movil_t/src/Models/libroReclamacion_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class LibroreclamacionService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<Map<String, dynamic>> registrarLibroReclamacion(
      LibroReclamacionModel libroreclamacion) async {
    final url = Uri.parse('$baseUrl/api/registrar-reclamo');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(libroreclamacion.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Error en la solicitud: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al registrar la libroreclamacion: $e');
    }
  }
}
