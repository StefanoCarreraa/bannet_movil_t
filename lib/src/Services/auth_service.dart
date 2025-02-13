import 'dart:convert';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<Map<String, dynamic>> login(
      String loginUsuario, String claveUsuario) async {
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(
        {"loginUsuario": loginUsuario, "claveUsuario": claveUsuario});

    final response = await http.post(Uri.parse('$baseUrl/Auth/login'),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      int iDUsuarioBannet = data['data']['user']['IDUsuarioBannet'] ?? 0;
      int iDPersona = data['data']['user']['IDPersona'] ?? 0;
      String nombreOrganizacion =
          data['data']['user']['NombreOrganizacion'] ?? '';
      int loginUsuario = data['data']['user']['LoginUsuario'] ?? 0;
      String emailOrganizacion =
          data['data']['user']['EmailOrganizacion'] ?? '';
      int iDOrganizacion = data['data']['user']['IDOrganizacion'] ?? 0;
      if (nombreOrganizacion.isNotEmpty) {
        await saveLoginSession(
          iDUsuarioBannet: iDUsuarioBannet,
          iDPersona: iDPersona,
          nombreOrganizacion: nombreOrganizacion,
          loginUsuario: loginUsuario,
          emailOrganizacion: emailOrganizacion,
          iDOrganizacion: iDOrganizacion,
        );
      }
      return data;
    } else {
      throw Exception('Error en la conexión con el servidor');
    }
  }

  Future<void> saveLoginSession({
    required int iDUsuarioBannet,
    required int iDPersona,
    required String nombreOrganizacion,
    required int loginUsuario,
    required String emailOrganizacion,
    required int iDOrganizacion,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setInt('IDUsuarioBannet', iDUsuarioBannet);
    await prefs.setInt('IDPersona', iDPersona);
    await prefs.setString('NombreOrganizacion', nombreOrganizacion);
    await prefs.setInt('LoginUsuario', loginUsuario);
    await prefs.setString('EmailOrganizacion', emailOrganizacion);
    await prefs.setInt('IDOrganizacion', iDOrganizacion);
    // Guarda el tiempo de inicio de sesión
    await prefs.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      int? loginTime = prefs.getInt('loginTime');
      if (loginTime != null) {
        // Calcula el tiempo transcurrido
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        int timeElapsed = currentTime - loginTime;

        // if (timeElapsed > 36000000) {
        //   // 10 horas en milisegundos
        //   await logout(); // Cierra sesión si ha pasado más de 10 horas
        //   return false;
        // }
      }
    }

    return isLoggedIn;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs
        .remove('NombreOrganizacion');
    await prefs.remove('loginTime');
  }
}
