import 'package:bannet_movil_t/src/Models/solicitudbaja_model.dart';
import 'package:bannet_movil_t/src/Services/solicitudbaja_service.dart';
import 'package:flutter/material.dart';

class BajaSuspensionController extends ChangeNotifier {
  final BajaSuspensionService _bajaSuspensionService = BajaSuspensionService();

  bool _isLoading = false;
  String? _responseMessage;

  bool get isLoading => _isLoading;
  String? get responseMessage => _responseMessage;

  Future<Map<String, dynamic>> registrarBajaSuspension(
      BajaSuspensionModel bajaSuspension) async {
    _isLoading = true;
    _responseMessage = null;
    notifyListeners();

    try {
      final result =
          await _bajaSuspensionService.registrarBajaSuspension(bajaSuspension);
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
