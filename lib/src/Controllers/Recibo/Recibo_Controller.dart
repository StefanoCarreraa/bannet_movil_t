import 'package:bannet_movil_t/src/Models/reciboPendiente_model.dart';
import 'package:bannet_movil_t/src/Services/reciboPendiente_service.dart';
import 'package:flutter/material.dart';

class ReciboController extends ChangeNotifier {
  final ReciboService _reciboService = ReciboService();
  List<ReciboPendienteModel> _recibos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ReciboPendienteModel> get recibos => _recibos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Nuevo getter para calcular el total a pagar
  double get totalMontoPagar {
    return _recibos.fold(0.0, (sum, recibo) {
      double importe =
          double.tryParse(recibo.importe.replaceAll("S/", "").trim()) ?? 0.0;
      return sum + importe;
    });
  }

  Future<void> fetchRecibosPendientes(int idPersona) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notifica a la UI que hay un cambio

    try {
      _recibos = await _reciboService.listarRecibosPendientes(idPersona);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
