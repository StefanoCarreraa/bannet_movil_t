import 'package:bannet_movil_t/src/Models/postventa_model.dart';
import 'package:bannet_movil_t/src/Services/postVenta_service.dart';
import 'package:flutter/material.dart';

class PostventaController extends ChangeNotifier {
  final PostventaService _postventaService = PostventaService();

  bool _isLoading = false;
  String? _responseMessage;

  bool get isLoading => _isLoading;
  String? get responseMessage => _responseMessage;
  List<PostventaModel> _postventaGamer = [];
  List<PostventaModel> get postventaGamer => _postventaGamer;

  Future<Map<String, dynamic>> registrarPostventa(
      PostventaModel postventa) async {
    _isLoading = true;
    _responseMessage = null;
    notifyListeners();

    try {
      final result = await _postventaService.registrarPostventa(postventa);
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

  Future<Map<String, dynamic>> registrarPostventaGamer(
      PostventaModel postventa) async {
    _isLoading = true;
    _responseMessage = null;
    notifyListeners();

    try {
      final result = await _postventaService.registrarPostventaGamer(postventa);
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

  Future<List<PostventaModel>> fetchPostventaGamer() async {
    _isLoading = true;
    try {
      List<PostventaModel> postventaData =
          await _postventaService.listarPostventaGamer();
      _postventaGamer = postventaData;
      return postventaData;
    } catch (e) {
      print('Error al obtener los postventa: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
