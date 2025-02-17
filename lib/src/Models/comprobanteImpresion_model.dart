class ComprobanteImpresionModel {
  String? tpdcCodigo;
  String? codSunat;
  int? idDocVenta;
  int? idDocVentaLinea;
  String? fecha;
  String? serie;
  String? numero;
  String? nroDocumento;
  String? observaciones;
  double? impuestos;
  double? isc;
  double? otrosImp;
  double? exonerada;
  double? inafecto;
  double? gratuito;
  double? neto;
  double? dcto;
  double? total;
  String? idDocumento;
  String? descripcion;
  String? tipoDocumento;
  String? tipoDocCliente;
  String? clieCodigo;
  String? nombreCliente;
  String? clieDireccion;
  String? documento;
  String? clieNroDocumento;
  int? idObra;
  String? obra;
  int? monCodigo;
  String? monDescripcion;
  String? nroGuiaRemision;
  String? glosa;
  String? glosaNewww;
  String? numdocccccc;
  String? nroNCredito;
  String? fCompra;
  String? numeroLetras;
  String? simboloMoneda;
  String? item;
  String? codUnidad2;
  String? codUnidad;
  double? cantidad;
  double? precio;
  double? importe;
  String? fechaDocReferente;
  String? tipoNotaCredito;
  String? despNotaCredito;
  String? rucEmpresa;
  String? direccionEmpresa;
  String? telefonoEmpresa;
  String? webEmpresa;
  String? resultadoEnvio;
  int? idPago;
  String? formaPago;
  String? fVcto;
  double? importeCuota;
  int? nroCuotas;
  int? idBancoDet;
  int? idCuentaDet;
  int? idBienes;
  int? idMedioPago;
  double? porcentajeDet;
  double? importeDet;
  int? idCuenta;
  String? observacionesDet;
  bool? flagDetraccion;

  ComprobanteImpresionModel({
    this.tpdcCodigo,
    this.codSunat,
    this.idDocVenta,
    this.idDocVentaLinea,
    this.fecha,
    this.serie,
    this.numero,
    this.nroDocumento,
    this.observaciones,
    this.impuestos,
    this.isc,
    this.otrosImp,
    this.exonerada,
    this.inafecto,
    this.gratuito,
    this.neto,
    this.dcto,
    this.total,
    this.idDocumento,
    this.descripcion,
    this.tipoDocumento,
    this.tipoDocCliente,
    this.clieCodigo,
    this.nombreCliente,
    this.clieDireccion,
    this.documento,
    this.clieNroDocumento,
    this.idObra,
    this.obra,
    this.monCodigo,
    this.monDescripcion,
    this.nroGuiaRemision,
    this.glosa,
    this.glosaNewww,
    this.numdocccccc,
    this.nroNCredito,
    this.fCompra,
    this.numeroLetras,
    this.simboloMoneda,
    this.item,
    this.codUnidad2,
    this.codUnidad,
    this.cantidad,
    this.precio,
    this.importe,
    this.fechaDocReferente,
    this.tipoNotaCredito,
    this.despNotaCredito,
    this.rucEmpresa,
    this.direccionEmpresa,
    this.telefonoEmpresa,
    this.webEmpresa,
    this.resultadoEnvio,
    this.idPago,
    this.formaPago,
    this.fVcto,
    this.importeCuota,
    this.nroCuotas,
    this.idBancoDet,
    this.idCuentaDet,
    this.idBienes,
    this.idMedioPago,
    this.porcentajeDet,
    this.importeDet,
    this.idCuenta,
    this.observacionesDet,
    this.flagDetraccion,
  });

  factory ComprobanteImpresionModel.fromJson(Map<String, dynamic> json) {
    return ComprobanteImpresionModel(
      tpdcCodigo: json['TPDC_CODIGO'],
      codSunat: json['COD_SUNAT'],
      idDocVenta: json['ID_DocVenta'],
      idDocVentaLinea: json['ID_Doc_VentaLinea'],
      fecha: json['Fecha'],
      serie: json['Serie'],
      numero: json['Numero'],
      nroDocumento: json['NRO_DOCUMENTO'],
      observaciones: json['Observaciones'],
      impuestos: json['Impuestos']?.toDouble(),
      isc: json['Isc']?.toDouble(),
      otrosImp: json['OtrosImp']?.toDouble(),
      exonerada: json['Exonerada']?.toDouble(),
      inafecto: json['Inafecto']?.toDouble(),
      gratuito: json['Gratuito']?.toDouble(),
      neto: json['Neto']?.toDouble(),
      dcto: json['Dcto']?.toDouble(),
      total: json['Total']?.toDouble(),
      idDocumento: json['ID_DOCUMENTO'],
      descripcion: json['DESCRIPCION'],
      tipoDocumento: json['TIPO_DOCUMENTO'],
      tipoDocCliente: json['TIPO_DOC_CLIENTE'],
      clieCodigo: json['CLIE_CODIGO'],
      nombreCliente: json['NOMBRE_CLIENTE'],
      clieDireccion: json['CLIE_DIRECCION'],
      documento: json['DOCUMENTO'],
      clieNroDocumento: json['CLIE_NRODOCUMENTO'],
      idObra: json['Id_Obra'],
      obra: json['OBRA'],
      monCodigo: json['MonCodigo'],
      monDescripcion: json['MonDescripcion'],
      nroGuiaRemision: json['NRO_GUIA_REMISION'],
      glosa: json['Glosa'],
      glosaNewww: json['GlosaNewww'],
      numdocccccc: json['numdocccccc'],
      nroNCredito: json['Nro_NCredito'],
      fCompra: json['F_Compra'],
      numeroLetras: json['NUMERO_LETRAS'],
      simboloMoneda: json['SIMBOLO_MONEDA'],
      item: json['Item'],
      codUnidad2: json['Cod_unidad_2'],
      codUnidad: json['Cod_unidad'],
      cantidad: json['CANTIDAD']?.toDouble(),
      precio: json['PRECIO']?.toDouble(),
      importe: json['IMPORTE']?.toDouble(),
      fechaDocReferente: json['FECHA_DOC_REFERENTE'],
      tipoNotaCredito: json['TIPO_NOTA_CREDITO'],
      despNotaCredito: json['DESP_NOTA_CREDITO'],
      rucEmpresa: json['RUC_EMPRESA'],
      direccionEmpresa: json['DIRECCION_EMPRESA'],
      telefonoEmpresa: json['TELEFONO_EMPRESA'],
      webEmpresa: json['WEB_EMPRESA'],
      resultadoEnvio: json['RESULTADO_ENVIO'],
      idPago: json['Id_Pago'],
      formaPago: json['FORMA_PAGO'],
      fVcto: json['F_vcto'],
      importeCuota: json['IMPORTE_CUOTA']?.toDouble(),
      nroCuotas: json['NroCuotas'],
      idBancoDet: json['ID_BANCO_DET'],
      idCuentaDet: json['ID_CUENTA_DET'],
      idBienes: json['ID_BIENES'],
      idMedioPago: json['ID_MEDIO_PAGO'],
      porcentajeDet: json['PORCENTAJE_DET']?.toDouble(),
      importeDet: json['IMPORTE_DET']?.toDouble(),
      idCuenta: json['ID_CUENTA'],
      observacionesDet: json['OBSERVCACIONES'],
      flagDetraccion: json['FLAG_DETRACCION'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TPDC_CODIGO': tpdcCodigo,
      'COD_SUNAT': codSunat,
      'ID_DocVenta': idDocVenta,
      'ID_Doc_VentaLinea': idDocVentaLinea,
      'Fecha': fecha,
      'Serie': serie,
      'Numero': numero,
      'NRO_DOCUMENTO': nroDocumento,
      'Observaciones': observaciones,
      'Impuestos': impuestos,
      'Isc': isc,
      'OtrosImp': otrosImp,
      'Exonerada': exonerada,
      'Inafecto': inafecto,
      'Gratuito': gratuito,
      'Neto': neto,
      'Dcto': dcto,
      'Total': total,
      'ID_DOCUMENTO': idDocumento,
      'DESCRIPCION': descripcion,
      'TIPO_DOCUMENTO': tipoDocumento,
      'TIPO_DOC_CLIENTE': tipoDocCliente,
      'CLIE_CODIGO': clieCodigo,
      'NOMBRE_CLIENTE': nombreCliente,
      'CLIE_DIRECCION': clieDireccion,
      'DOCUMENTO': documento,
      'CLIE_NRODOCUMENTO': clieNroDocumento,
      'Id_Obra': idObra,
      'OBRA': obra,
      'MonCodigo': monCodigo,
      'MonDescripcion': monDescripcion,
      'NRO_GUIA_REMISION': nroGuiaRemision,
      'Glosa': glosa,
      'GlosaNewww': glosaNewww,
      'numdocccccc': numdocccccc,
      'Nro_NCredito': nroNCredito,
      'F_Compra': fCompra,
      'NUMERO_LETRAS': numeroLetras,
      'SIMBOLO_MONEDA': simboloMoneda,
      'Item': item,
      'Cod_unidad_2': codUnidad2,
      'Cod_unidad': codUnidad,
      'CANTIDAD': cantidad,
      'PRECIO': precio,
      'IMPORTE': importe,
      'FECHA_DOC_REFERENTE': fechaDocReferente,
      'TIPO_NOTA_CREDITO': tipoNotaCredito,
      'DESP_NOTA_CREDITO': despNotaCredito,
      'RUC_EMPRESA': rucEmpresa,
      'DIRECCION_EMPRESA': direccionEmpresa,
      'TELEFONO_EMPRESA': telefonoEmpresa,
      'WEB_EMPRESA': webEmpresa,
      'RESULTADO_ENVIO': resultadoEnvio,
      'Id_Pago': idPago,
      'FORMA_PAGO': formaPago,
      'F_vcto': fVcto,
      'IMPORTE_CUOTA': importeCuota,
      'NroCuotas': nroCuotas,
      'ID_BANCO_DET': idBancoDet,
      'ID_CUENTA_DET': idCuentaDet,
      'ID_BIENES': idBienes,
      'ID_MEDIO_PAGO': idMedioPago,
      'PORCENTAJE_DET': porcentajeDet,
      'IMPORTE_DET': importeDet,
      'ID_CUENTA': idCuenta,
      'OBSERVCACIONES': observacionesDet,
      'FLAG_DETRACCION': flagDetraccion == true ? 1 : 0,
    };
  }
}
