class ReciboimpresionModel {
  final String idDocCobrar;
  final String cantidad;
  final String descripcion;
  final String numDocumento;
  final String anio;
  final String nroContrato;
  final String mesNum;
  final String mes;
  final String? fechaEmision;
  final String? fechaEmision_name;

  final String? fechaVencimiento;
  final String? fechaVencimiento_1;

  final String periodo;
  final String entregado;
  final String extrajudicial;
  final String idPersona;
  final String persona;
  final String documento;
  final String dni;
  final String email;
  final String telefono;
  final String direccion;
  final String tipoDocId;
  final String? itemDescripcion;
  final String idMoneda;
  final String nombreMoneda;
  final String glosa;
  final String importe;
  final String amortizado;
  final String saldo;
  final String estadoLetras;
  final String estadoInmueble;
  final String usuario;
  final String fechaIngreso;
  final String tiinNombre;
  final String numeroLetras;
  final String simboloMoneda;
  final String rucEmpresa;
  final String webEmpresa;
  final String direccionEmpresa;
  final String telefonoEmpresa;

  ReciboimpresionModel({
    required this.idDocCobrar,
    required this.cantidad,
    required this.descripcion,
    required this.numDocumento,
    required this.anio,
    required this.nroContrato,
    required this.mesNum,
    required this.mes,
    this.fechaEmision,
    this.fechaEmision_name,
    this.fechaVencimiento,
    this.fechaVencimiento_1,
    required this.periodo,
    required this.entregado,
    required this.extrajudicial,
    required this.idPersona,
    required this.persona,
    required this.documento,
    required this.dni,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.tipoDocId,
    this.itemDescripcion,
    required this.idMoneda,
    required this.nombreMoneda,
    required this.glosa,
    required this.importe,
    required this.amortizado,
    required this.saldo,
    required this.estadoLetras,
    required this.estadoInmueble,
    required this.usuario,
    required this.fechaIngreso,
    required this.tiinNombre,
    required this.numeroLetras,
    required this.simboloMoneda,
    required this.rucEmpresa,
    required this.webEmpresa,
    required this.direccionEmpresa,
    required this.telefonoEmpresa,
  });

  factory ReciboimpresionModel.fromJson(Map<String, dynamic> json) {
    return ReciboimpresionModel(
      idDocCobrar: json["ID_DOC_COBRAR"].toString(),
      cantidad: json["CANTIDAD"].toString(),
      descripcion: json["DESCRIPCION"].toString(),
      numDocumento: json["NUM_DOCUMENTO"].toString(),
      anio: json["AÑO"].toString(),
      nroContrato: json["NRO_CONTRATO"].toString(),
      mesNum: json["MES_NUM"].toString(),
      mes: json["MES"].toString(),
      fechaEmision: json["PFECHA_P_EMISION"].toString(),
      fechaEmision_name: json["FECHA_EMISION_NAME"].toString(),
      fechaVencimiento: json["PFECHA_P_VENCIMIENTO"].toString(),
      fechaVencimiento_1: json["PFECHA_P_VENCIMIENTO_1"].toString(),
      periodo: json["PERIODO"].toString(),
      entregado: json["ENTREGADO"].toString(),
      extrajudicial: json["EXTRAJUDICIAL"].toString(),
      idPersona: json["ID_PERSONA"].toString(),
      persona: json["PERSONA"].toString(),
      documento: json["DOCUMENTO"].toString(),
      dni: json["DNI"].toString(),
      email: json["EMAIL"].toString(),
      telefono: json["TELEFONO"].toString(),
      direccion: json["DIRECCION"].toString(),
      tipoDocId: json["TIPO_DOC_ID"].toString(),
      itemDescripcion: json["ITEM_DESCRIPCION"].toString(),
      idMoneda: json["ID_MONEDA"].toString(),
      nombreMoneda: json["NOMBRE"].toString(),
      glosa: json["GLOSA"].toString(),
      importe: json["IMPORTE"].toString(),
      amortizado: json["AMORTIZADO"].toString(),
      saldo: json["SALDO"].toString(),
      estadoLetras: json["ESTADO_LETRAS"].toString(),
      estadoInmueble: json["ESTADO_INMUEBLE"].toString(),
      usuario: json["USUARIO"].toString(),
      fechaIngreso: json["FECHA_INGRESO"].toString(),
      tiinNombre: json["TIIN_NOMBRE"].toString(),
      numeroLetras: json["NUMERO_LETRAS"].toString(),
      simboloMoneda: json["SIMBOLO_MONEDA"].toString(),
      rucEmpresa: json["RUC_EMPRESA"].toString(),
      webEmpresa: json["WEB_EMPRESA"].toString(),
      direccionEmpresa: json["DIRECCION_EMPRESA"].toString(),
      telefonoEmpresa: json["TELEFONO_EMPRESA"].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ID_DOC_COBRAR': idDocCobrar,
      'CANTIDAD': cantidad,
      'DESCRIPCION': descripcion,
      'NUM_DOCUMENTO': numDocumento,
      'AÑO': anio,
      'NRO_CONTRATO': nroContrato,
      'MES_NUM': mesNum,
      'MES': mes,
      'PFECHA_P_EMISION': fechaEmision,
      'FECHA_EMISION_NAME': fechaEmision_name,
      'PFECHA_P_VENCIMIENTO': fechaVencimiento,
      'PFECHA_P_VENCIMIENTO_1': fechaVencimiento_1,
      'PERIODO': periodo,
      'ENTREGADO': entregado,
      'EXTRAJUDICIAL': extrajudicial,
      'ID_PERSONA': idPersona,
      'PERSONA': persona,
      'DOCUMENTO': documento,
      'DNI': dni,
      'EMAIL': email,
      'TELEFONO': telefono,
      'DIRECCION': direccion,
      'TIPO_DOC_ID': tipoDocId,
      'ITEM_DESCRIPCION': itemDescripcion,
      'ID_MONEDA': idMoneda,
      'NOMBRE': nombreMoneda,
      'GLOSA': glosa,
      'IMPORTE': importe,
      'AMORTIZADO': amortizado,
      'SALDO': saldo,
      'ESTADO_LETRAS': estadoLetras,
      'ESTADO_INMUEBLE': estadoInmueble,
      'USUARIO': usuario,
      'FECHA_INGRESO': fechaIngreso,
      'TIIN_NOMBRE': tiinNombre,
      'NUMERO_LETRAS': numeroLetras,
      'SIMBOLO_MONEDA': simboloMoneda,
      'RUC_EMPRESA': rucEmpresa,
      'WEB_EMPRESA': webEmpresa,
      'DIRECCION_EMPRESA': direccionEmpresa,
      'TELEFONO_EMPRESA': telefonoEmpresa,
    };
  }
}
