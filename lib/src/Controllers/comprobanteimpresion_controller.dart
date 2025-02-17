import 'package:bannet_movil_t/src/Models/comprobanteImpresion_model.dart';
import 'package:bannet_movil_t/src/Services/comprobanteImpresion_service.dart';
import 'package:flutter/material.dart';

class ComprobanteImpresionController extends ChangeNotifier {
  final ComprobanteImpresionService _service = ComprobanteImpresionService();
  List<ComprobanteImpresionModel> _comprobantes = [];
  bool _isLoading = false;
  String? _errorMessage;


  List<ComprobanteImpresionModel> get comprobantes => _comprobantes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchComprobantesPendientes(int idDocVenta) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _comprobantes = await _service.getComprobantesImpresion(idDocVenta);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
