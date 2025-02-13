class ComprobanteModel {
  final int idDocVenta;
  final String fecha;
  final String serie;
  final String numero;
  final String nroComprobante;
  final double neto;
  final int total;
  final int idDocumento;
  final String simboloMoneda;
  final String monDescripcion;
  final int flagDetraccion;

  ComprobanteModel({
    required this.idDocVenta,
    required this.fecha,
    required this.serie,
    required this.numero,
    required this.nroComprobante,
    required this.neto,
    required this.total,
    required this.idDocumento,
    required this.simboloMoneda,
    required this.monDescripcion,
    required this.flagDetraccion,
  });

  factory ComprobanteModel.fromJson(Map<String, dynamic> json) {
    return ComprobanteModel(
      idDocVenta: json['ID_DocVenta'],
      fecha: json['Fecha'],
      serie: json['Serie'],
      numero: json['Numero'],
      nroComprobante: json['NroComprobante'],
      neto: json['Neto'],
      total: json['Total'],
      idDocumento: json['ID_Documento'],
      simboloMoneda: json['SimboloMoneda'],
      monDescripcion: json['MonDescripcion'],
      flagDetraccion: json['Flag_Detraccion'],
    );
  }
}
