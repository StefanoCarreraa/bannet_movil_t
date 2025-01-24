import 'dart:async';

import 'package:bannet_movil_t/src/View/Home/IndexScreen.dart';
import 'package:bannet_movil_t/src/View/Login/loginScreen.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';

class LoginController with ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<bool> attemptLogin(
      String usuario, String clave, BuildContext context) async {
    if (usuario.isEmpty || clave.isEmpty) {
      _showSnackBar(context, 'Por favor ingresa tus credenciales');
      return false;
    }

    try {
      // Limitar tiempo de espera a 5 segundos
      final response = await Future.any([
        _authService.login(usuario, clave),
        // Future.delayed(const Duration(seconds: 5), () {
        //   throw TimeoutException('No se pudo conectar con el servidor.');
        // }),
      ]);

      if (response['status'] == 'success') {
        final iDUsuarioBannet =
            response['data']['user']['IDUsuarioBannet'] ?? 0;
        final iDPersona = response['data']['user']['IDPersona'] ?? 0;
        final nombreOrganizacion =
            response['data']['user']['NombreOrganizacion'] ?? '';
        final loginUsuario = response['data']['user']['LoginUsuario'] ?? 0;
        final emailOrganizacion =
            response['data']['user']['EmailOrganizacion'] ?? '';
        final iDOrganizacion = response['data']['user']['IDOrganizacion'] ?? 0;

        await _authService.saveLoginSession(
          iDUsuarioBannet: iDUsuarioBannet,
          iDPersona: iDPersona,
          nombreOrganizacion: nombreOrganizacion,
          loginUsuario: loginUsuario,
          emailOrganizacion: emailOrganizacion,
          iDOrganizacion: iDOrganizacion,
        );

        if (context.mounted) {
          _showSuccessDialog(
              context, iDUsuarioBannet, nombreOrganizacion, iDOrganizacion);
        }
        return true;
      } else {
        if (context.mounted) {
          _showSnackBar(context, 'Credenciales inválidas');
        }
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context,
            e is TimeoutException ? e.message! : 'Error de conexión: $e');
      }
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('NombreOrganizacion');
    await prefs.remove('loginTime');

    // Verifica si el contexto está montado antes de navegar
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Loginscreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<bool> checkLoginStatus() async {
    return await _authService.checkLoginStatus();
  }

  void _showSuccessDialog(BuildContext context, int idUsuario,
      String nombreUsuario, int iDTipoUsuario) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.grisOscuro,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicador de deslizar
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.grisFondo,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              // Contenido del diálogo
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Logo
                    SizedBox(
                      height: 70,
                      child: Image.asset(
                        'assets/images/logo_miportal.png', // Ruta de tu logo en assets
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Mensaje de éxito
                    Text(
                      'Inicio de sesión exitoso!!!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.verdeLima,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      nombreUsuario,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '¡Disfruta de tu experiencia!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.verdeLima,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 40),
                    // Botón Cancelar
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blanco,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el diálogo
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Indexscreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Continuar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'idUsuarioBannet': prefs.getInt('IDUsuarioBannet') ?? 0,
      'idPersona': prefs.getInt('IDPersona') ?? 0,
      'nombreOrganizacion': prefs.getString('NombreOrganizacion') ??
          'NombreOrganizacion desconocido',
      'loginUsuario': prefs.getInt('LoginUsuario') ?? 0,
      'emailOrganizacion': prefs.getString('EmailOrganizacion') ??
          'EmailOrganizacion desconocido',
      'idOrganizacion': prefs.getInt('IDOrganizacion') ?? 0,
    };
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
