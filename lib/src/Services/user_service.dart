import 'dart:convert';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = AppCconfig.baseUrl;

  // Método para modificar la clave del usuario
  Future<bool> cambiarClave(int idUsuario, String nuevaClave) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/usuario/clave'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"IDUsuarioBannet": idUsuario, "Clave": nuevaClave}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error al cambiar clave: $e");
      return false;
    }
  }

  // Método para modificar el email del usuario
  Future<bool> cambiarEmail(int idUsuario, String nuevoEmail) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/usuario/email'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"IDUsuarioBannet": idUsuario, "Email": nuevoEmail}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error al cambiar email: $e");
      return false;
    }
  }

  // Método para modificar el telefono del usuario
  Future<bool> cambiarTelefono(int idUsuario, String telefono) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/usuario/telefono'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"IDUsuarioBannet": idUsuario, "Telefono": telefono}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error al cambiar email: $e");
      return false;
    }
  }
}
