class LibroReclamacionModel {
  final int idServicioContratado;
  final String tipoReclamo;
  final String observacion;

  LibroReclamacionModel({
    required this.idServicioContratado,
    required this.tipoReclamo,
    required this.observacion,
  });

  Map<String, dynamic> toJson() {
    return {
      'IDServicioContratado': idServicioContratado,
      'TipoReclamo': tipoReclamo,
      'Observacion': observacion,
    };
  }
}
