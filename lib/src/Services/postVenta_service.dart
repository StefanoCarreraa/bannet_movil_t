import 'dart:convert';
import 'package:bannet_movil_t/src/Models/postventa_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class PostventaService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<Map<String, dynamic>> registrarPostventa(
      PostventaModel postventa) async {
    final url = Uri.parse('$baseUrl/api/postventa');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postventa.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Error en la solicitud: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al registrar la postventa registrarPostventa: $e');
    }
  }

   Future<Map<String, dynamic>> registrarPostventaGamer(
      PostventaModel postventa) async {
    final url = Uri.parse('$baseUrl/api/registrar-postventa-gamer');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postventa.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Error en la solicitud: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al registrar la postventa registrarPostventaGamer: $e');
    }
  }

Future<List<PostventaModel>> listarPostventaGamer() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/api/servicios-postventa-gamer'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(response.body);
      
      // Acceder a la clave "data"
      List<dynamic> data = decodedData["data"] ?? [];

      return data.map((json) => PostventaModel.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error en la solicitud: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    throw Exception('Error al registrar la postventa listarPostventaGamer: $e');
  }
}

}
