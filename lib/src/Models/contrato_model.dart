class ContratoModel {
  final int iDServicioContratado;
  final String nombreServicio;

  ContratoModel({
    required this.iDServicioContratado,
    required this.nombreServicio,
  });

  ContratoModel.empty()
      : iDServicioContratado = 0,
        nombreServicio = 'Sin Servicio';

  factory ContratoModel.fromJson(Map<String, dynamic> json) {
    return ContratoModel(
      iDServicioContratado: json['IDServicioContratado'],
      nombreServicio: json['NombreServicio'],
    );
  }

  static List<ContratoModel> listFromJson(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => ContratoModel.fromJson(json)).toList();
  }
}
