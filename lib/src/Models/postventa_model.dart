class PostventaModel {
  final int idServicioContratado;
  final int idCategoriaTicket;
  final String observacion;

  final String? descripcionCategoriaTicket;

  PostventaModel({
    required this.idServicioContratado,
    required this.idCategoriaTicket,
    required this.observacion,
    this.descripcionCategoriaTicket,
  });

  PostventaModel.empty()
      : idServicioContratado = 0,
        idCategoriaTicket = 0,
        observacion = '',
        descripcionCategoriaTicket = '';

  Map<String, dynamic> toJson() {
    return {
      'IDServicioContratado': idServicioContratado ?? 0,
      'IDCategoriaTicket': idCategoriaTicket ?? 0,
      'Observacion': observacion ?? '',
      'DescripcionCategoriaTicket': descripcionCategoriaTicket ?? '',
    };
  }

  factory PostventaModel.fromJson(Map<String, dynamic> json) {
    return PostventaModel(
      idServicioContratado: json['IDServicioContratado'] ?? 0,
      idCategoriaTicket: json['IDCategoriaTicket'] ?? 0,
      observacion: json['Observacion'] ?? '',
      descripcionCategoriaTicket: json['DescripcionCategoriaTicket'] ?? '',
    );
  }

  static List<PostventaModel> listFromJson(
      List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => PostventaModel.fromJson(json)).toList();
  }
}
