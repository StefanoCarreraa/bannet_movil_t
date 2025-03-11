import 'package:flutter/material.dart';
import '../services/user_service.dart';

class UserController extends ChangeNotifier {
  final UserService _userService = UserService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Método para cambiar clave
  Future<bool> cambiarClave(int idUsuarioBannet, String nuevaClave) async {
    _setLoading(true);
    try {
      final resultado =
          await _userService.cambiarClave(idUsuarioBannet, nuevaClave);
      return resultado;
    } catch (e) {
      print("Error al cambiar clave: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Método para cambiar Email
  Future<bool> cambiarEmail(int idUsuarioBannet, String nuevoEmail) async {
    _setLoading(true);
    try {
      final resultado =
          await _userService.cambiarEmail(idUsuarioBannet, nuevoEmail);
      return resultado;
    } catch (e) {
      print("Error al cambiar email: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Método para cambiar Teléfono
  Future<bool> cambiarTelefono(int idUsuarioBannet, String telefono) async {
    _setLoading(true);
    try {
      final resultado =
          await _userService.cambiarTelefono(idUsuarioBannet, telefono);
      return resultado;
    } catch (e) {
      print("Error al cambiar teléfono: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Método privado para manejar el estado de carga
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
