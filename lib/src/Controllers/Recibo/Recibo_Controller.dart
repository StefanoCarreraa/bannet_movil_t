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

  Future<void> fetchRecibosPendientes(int idPersona) async {
    _isLoading = true;
    _errorMessage = null;

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
