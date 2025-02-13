class ReciboimpresionModel {
  final int idDocCobrar;
  final int cantidad;
  final String descripcion;
  final String numDocumento;
  final int anio;
  final String nroContrato;
  final int mesNum;
  final String mes;
  final String? fechaEmision;
  final String? fechaEmision_name;

  final String? fechaVencimiento;
  final String? fechaVencimiento_1;

  final String periodo;
  final String entregado;
  final String extrajudicial;
  final int idPersona;
  final String persona;
  final String documento;
  final String dni;
  final String email;
  final String telefono;
  final String direccion;
  final String tipoDocId;
  final String? itemDescripcion;
  final int idMoneda;
  final String nombreMoneda;
  final String glosa;
  final double importe;
  final double amortizado;
  final double saldo;
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
      idDocCobrar: json["ID_DOC_COBRAR"],
      cantidad: json["CANTIDAD"],
      descripcion: json["DESCRIPCION"],
      numDocumento: json["NUM_DOCUMENTO"],
      anio: json["AÑO"],
      nroContrato: json["NRO_CONTRATO"],
      mesNum: json["MES_NUM"],
      mes: json["MES"],
      fechaEmision: json["PFECHA_P_EMISION"],
      fechaEmision_name: json["FECHA_EMISION_NAME"],
      fechaVencimiento: json["PFECHA_P_VENCIMIENTO"],
      fechaVencimiento_1: json["PFECHA_P_VENCIMIENTO_1"],
      periodo: json["PERIODO"],
      entregado: json["ENTREGADO"],
      extrajudicial: json["EXTRAJUDICIAL"],
      idPersona: json["ID_PERSONA"],
      persona: json["PERSONA"],
      documento: json["DOCUMENTO"],
      dni: json["DNI"],
      email: json["EMAIL"],
      telefono: json["TELEFONO"],
      direccion: json["DIRECCION"],
      tipoDocId: json["TIPO_DOC_ID"],
      itemDescripcion: json["ITEM_DESCRIPCION"],
      idMoneda: json["ID_MONEDA"],
      nombreMoneda: json["NOMBRE"],
      glosa: json["GLOSA"],
      importe: (json["IMPORTE"] as num).toDouble(),
      amortizado: (json["AMORTIZADO"] as num).toDouble(),
      saldo: (json["SALDO"] as num).toDouble(),
      estadoLetras: json["ESTADO_LETRAS"],
      estadoInmueble: json["ESTADO_INMUEBLE"],
      usuario: json["USUARIO"],
      fechaIngreso: json["FECHA_INGRESO"],
      tiinNombre: json["TIIN_NOMBRE"],
      numeroLetras: json["NUMERO_LETRAS"],
      simboloMoneda: json["SIMBOLO_MONEDA"],
      rucEmpresa: json["RUC_EMPRESA"],
      webEmpresa: json["WEB_EMPRESA"],
      direccionEmpresa: json["DIRECCION_EMPRESA"],
      telefonoEmpresa: json["TELEFONO_EMPRESA"],
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
