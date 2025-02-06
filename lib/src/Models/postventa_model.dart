class PostventaModel {
  final int idServicioContratado;
  final int idCategoriaTicket;
  final String observacion;

  PostventaModel({
    required this.idServicioContratado,
    required this.idCategoriaTicket,
    required this.observacion,
  });

  Map<String, dynamic> toJson() {
    return {
      'IDServicioContratado': idServicioContratado,
      'IDCategoriaTicket': idCategoriaTicket,
      'Observacion': observacion,
    };
  }
}
