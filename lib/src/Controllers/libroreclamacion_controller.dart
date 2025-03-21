import 'package:bannet_movil_t/src/Models/libroReclamacion_model.dart';
import 'package:bannet_movil_t/src/Models/postventa_model.dart';
import 'package:bannet_movil_t/src/Services/libroReclamacion_service.dart';
import 'package:bannet_movil_t/src/Services/postVenta_service.dart';
import 'package:flutter/material.dart';

class LibroReclamacionController extends ChangeNotifier {
  final LibroreclamacionService _libroreclamacionService = LibroreclamacionService();

  bool _isLoading = false;
  String? _responseMessage;

  bool get isLoading => _isLoading;
  String? get responseMessage => _responseMessage;

  Future<Map<String, dynamic>> registrarLibroReclamacion(
      LibroReclamacionModel libroreclamacion) async {
    _isLoading = true;
    _responseMessage = null;
    notifyListeners();

    try {
      final result = await _libroreclamacionService.registrarLibroReclamacion(libroreclamacion);
      _responseMessage = result['message'];
      return result; // Devuelve el resultado completo
    } catch (e) {
      _responseMessage = 'Error: $e';
      return {'error': e}; // Devuelve un mapa con el error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
