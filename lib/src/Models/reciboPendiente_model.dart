class ReciboPendienteModel {
  final int idDocCobrar;
  final String numeroRecibo;
  final String periodo;
  final String numeroContrato;
  final String nombreServicio;
  final String nombreMoneda;
  final String importe;
  final String nombreEstadoRecibo;

  ReciboPendienteModel({
    required this.idDocCobrar,
    required this.numeroRecibo,
    required this.periodo,
    required this.numeroContrato,
    required this.nombreServicio,
    required this.nombreMoneda,
    required this.importe,
    required this.nombreEstadoRecibo,
  });

  factory ReciboPendienteModel.fromJson(Map<String, dynamic> json) {
    return ReciboPendienteModel(
      idDocCobrar: json['IDDocCobrar'],
      numeroRecibo: json['NumeroRecibo'],
      periodo: json['Periodo'],
      numeroContrato: json['NumeroContrato'],
      nombreServicio: json['NombreServicio'],
      nombreMoneda: json['NombreMoneda'],
      importe: json['Importe'],
      nombreEstadoRecibo: json['NombreEstadoRecibo'],
    );
  }
}
