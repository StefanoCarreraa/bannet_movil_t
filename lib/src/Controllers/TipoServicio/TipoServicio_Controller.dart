import 'package:bannet_movil_t/src/Models/tipoServicio_model.dart';
import 'package:bannet_movil_t/src/Services/tipoServicio_service.dart';
import 'package:flutter/material.dart';

class TipoServicioController with ChangeNotifier {
  final TipoServicioService _tipoServicioService = TipoServicioService();

  List<TipoServicioModel> _tipoServicios = [];
  bool _isLoading = false;

  List<TipoServicioModel> get tipoServicios => _tipoServicios;
  bool get isLoading => _isLoading;

  // Método para obtener la lista de Cuadrilla de la API
  Future<List<TipoServicioModel>> fetchTipoServicios() async {
    _isLoading = true;
    //notifyListeners();

    try {
      List<TipoServicioModel> tipoServiciosData =
          await _tipoServicioService.fetchTipoServicio();
      _tipoServicios = tipoServiciosData;
      return tipoServiciosData;
    } catch (e) {
      print('Error al obtener los Tipos de Servicios: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
