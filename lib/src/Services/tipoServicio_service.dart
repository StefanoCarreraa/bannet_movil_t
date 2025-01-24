import 'package:bannet_movil_t/src/Models/tipoServicio_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipoServicioService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<List<TipoServicioModel>> fetchTipoServicio() async {
    final response = await http.get(Uri.parse('$baseUrl/api/tipoServicio'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => TipoServicioModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los tipos de servicios');
    }
  }
}
