import 'package:bannet_movil_t/src/Models/comprobante_model.dart';
import 'package:bannet_movil_t/src/Services/comprobante_service.dart';
import 'package:flutter/material.dart';

class ComprobanteController extends ChangeNotifier {
  final ComprobanteService _comprobanteService = ComprobanteService();

  List<ComprobanteModel> _comprobantes = [];
  bool isLoading = false;
  String? _errorMessage;

  List<ComprobanteModel> get comprobantes => _comprobantes;
  String? get errorMessage => _errorMessage;

  Future<void> fetchComprobantes(int idPersona) async {
    isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _comprobantes = await _comprobanteService.listarComprobantes(idPersona);
    } catch (e) {
      _errorMessage = e.toString();
      print(comprobantes);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
