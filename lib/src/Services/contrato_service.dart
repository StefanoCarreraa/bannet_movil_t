import 'package:bannet_movil_t/src/Models/contrato_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContratoService {
  final String baseUrl = AppCconfig.baseUrl;

  Future<List<ContratoModel>> fetchContratos(int iDOrganizacion) async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/contrato?IDOrganizacion=$iDOrganizacion'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ContratoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los Contratos');
    }
  }
}