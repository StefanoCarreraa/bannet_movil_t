import 'package:bannet_movil_t/src/Models/reciboImpresion_model%20.dart';
import 'package:flutter/material.dart';
import 'package:bannet_movil_t/src/Services/reciboImpresion_service.dart';

class ReciboImpresionController extends ChangeNotifier {
  final ReciboImpresionService _service = ReciboImpresionService();
  List<ReciboimpresionModel> _recibos = [];
  bool _isLoading = false;
  String? _errorMessage;


  List<ReciboimpresionModel> get recibos => _recibos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchRecibosPendientes(int idDocCobrar) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _recibos = await _service.getRecibosPendientesImpresion(idDocCobrar);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
