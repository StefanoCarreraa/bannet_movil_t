import 'package:bannet_movil_t/src/Models/contrato_model.dart';
import 'package:bannet_movil_t/src/Services/contrato_service.dart';
import 'package:flutter/material.dart';

class ContratoController with ChangeNotifier {
  final ContratoService _contratoService = ContratoService();

  List<ContratoModel> _contratos = [];
  bool _isLoading = false;

  List<ContratoModel> get contratos => _contratos;
  bool get isLoading => _isLoading;

  // Método para obtener la lista de Boletasalida de la API
  Future<List<ContratoModel>> fetchContratos(int iDOrganizacion) async {
    _isLoading = true;

    try {
      List<ContratoModel> contratosData =
          await _contratoService.fetchContratos(iDOrganizacion);
      _contratos = contratosData;
      return contratosData;
    } catch (e) {
      print('Error al obtener los Contratos: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
