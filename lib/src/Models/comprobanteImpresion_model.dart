class ComprobanteImpresionModel {
  final String tpdcCodigo;
  final String codSunat;
  final String idDocVenta;
  final String idDocVentaLinea;
  final String fecha;
  final String serie;
  final String numero;
  final String nroDocumento;
  final String? observaciones;
  final String impuestos;
  final String isc;
  final String otrosImp;
  final String exonerada;
  final String inafecto;
  final String gratuito;
  final String neto;
  final String dcto;
  final String total;
  final String idDocumento;
  final String descripcion;
  final String tipoDocumento;
  final String tipoDocCliente;
  final String clieCodigo;
  final String nombreCliente;
  final String clieDireccion;
  final String documento;
  final String clieNroDocumento;
  final String idObra;
  final String obra;
  final String monCodigo;
  final String monDescripcion;
  final String nroGuiaRemision;
  final String glosa;
  final String glosaNewww;
  final String numdocccccc;
  final String? nroNCredito;
  final String? fCompra;
  final String numeroLetras;
  final String simboloMoneda;
  final String item;
  final String codUnidad2;
  final String codUnidad;
  final String cantidad;
  final String precio;
  final String importe;
  final String? fechaDocReferente;
  final String? tipoNotaCredito;
  final String? despNotaCredito;
  final String rucEmpresa;
  final String direccionEmpresa;
  final String telefonoEmpresa;
  final String webEmpresa;
  final String resultadoEnvio;
  final String idPago;
  final String formaPago;
  final String fVcto;
  final String importeCuota;
  final String nroCuotas;
  final String idBancoDet;
  final String idCuentaDet;
  final String idBienes;
  final String idMedioPago;
  final String porcentajeDet;
  final String importeDet;
  final String idCuenta;
  final String observacionesDet;
  final String flagDetraccion;

  ComprobanteImpresionModel({
    required this.tpdcCodigo,
    required this.codSunat,
    required this.idDocVenta,
    required this.idDocVentaLinea,
    required this.fecha,
    required this.serie,
    required this.numero,
    required this.nroDocumento,
    this.observaciones,
    required this.impuestos,
    required this.isc,
    required this.otrosImp,
    required this.exonerada,
    required this.inafecto,
    required this.gratuito,
    required this.neto,
    required this.dcto,
    required this.total,
    required this.idDocumento,
    required this.descripcion,
    required this.tipoDocumento,
    required this.tipoDocCliente,
    required this.clieCodigo,
    required this.nombreCliente,
    required this.clieDireccion,
    required this.documento,
    required this.clieNroDocumento,
    required this.idObra,
    required this.obra,
    required this.monCodigo,
    required this.monDescripcion,
    required this.nroGuiaRemision,
    required this.glosa,
    required this.glosaNewww,
    required this.numdocccccc,
    this.nroNCredito,
    this.fCompra,
    required this.numeroLetras,
    required this.simboloMoneda,
    required this.item,
    required this.codUnidad2,
    required this.codUnidad,
    required this.cantidad,
    required this.precio,
    required this.importe,
    this.fechaDocReferente,
    this.tipoNotaCredito,
    this.despNotaCredito,
    required this.rucEmpresa,
    required this.direccionEmpresa,
    required this.telefonoEmpresa,
    required this.webEmpresa,
    required this.resultadoEnvio,
    required this.idPago,
    required this.formaPago,
    required this.fVcto,
    required this.importeCuota,
    required this.nroCuotas,
    required this.idBancoDet,
    required this.idCuentaDet,
    required this.idBienes,
    required this.idMedioPago,
    required this.porcentajeDet,
    required this.importeDet,
    required this.idCuenta,
    required this.observacionesDet,
    required this.flagDetraccion,
  });

  factory ComprobanteImpresionModel.fromJson(Map<String, dynamic> json) {
    return ComprobanteImpresionModel(
      tpdcCodigo: json['TPDC_CODIGO'].toString(),
      codSunat: json['COD_SUNAT'].toString(),
      idDocVenta: json['ID_DocVenta'].toString(),
      idDocVentaLinea: json['ID_Doc_VentaLinea'].toString(),
      fecha: json['Fecha'].toString(),
      serie: json['Serie'].toString(),
      numero: json['Numero'].toString(),
      nroDocumento: json['NRO_DOCUMENTO'].toString(),
      observaciones: json['Observaciones']?.toString(),
      impuestos: json['Impuestos'].toString(),
      isc: json['Isc'].toString(),
      otrosImp: json['OtrosImp'].toString(),
      exonerada: json['Exonerada'].toString(),
      inafecto: json['Inafecto'].toString(),
      gratuito: json['Gratuito'].toString(),
      neto: json['Neto'].toString(),
      dcto: json['Dcto'].toString(),
      total: json['Total'].toString(),
      idDocumento: json['ID_DOCUMENTO'].toString(),
      descripcion: json['DESCRIPCION'].toString(),
      tipoDocumento: json['TIPO_DOCUMENTO'].toString(),
      tipoDocCliente: json['TIPO_DOC_CLIENTE'].toString(),
      clieCodigo: json['CLIE_CODIGO'].toString(),
      nombreCliente: json['NOMBRE_CLIENTE'].toString(),
      clieDireccion: json['CLIE_DIRECCION'].toString(),
      documento: json['DOCUMENTO'].toString(),
      clieNroDocumento: json['CLIE_NRODOCUMENTO'].toString(),
      idObra: json['Id_Obra'].toString(),
      obra: json['OBRA'].toString(),
      monCodigo: json['MonCodigo'].toString(),
      monDescripcion: json['MonDescripcion'].toString(),
      nroGuiaRemision: json['NRO_GUIA_REMISION'].toString(),
      glosa: json['Glosa'].toString(),
      glosaNewww: json['GlosaNewww'].toString(),
      numdocccccc: json['numdocccccc'].toString(),
      nroNCredito: json['Nro_NCredito']?.toString(),
      fCompra: json['F_Compra']?.toString(),
      numeroLetras: json['NUMERO_LETRAS'].toString(),
      simboloMoneda: json['SIMBOLO_MONEDA'].toString(),
      item: json['Item'].toString(),
      codUnidad2: json['Cod_unidad_2'].toString(),
      codUnidad: json['Cod_unidad'].toString(),
      cantidad: json['CANTIDAD'].toString(),
      precio: json['PRECIO'].toString(),
      importe: json['IMPORTE'].toString(),
      fechaDocReferente: json['FECHA_DOC_REFERENTE']?.toString(),
      tipoNotaCredito: json['TIPO_NOTA_CREDITO']?.toString(),
      despNotaCredito: json['DESP_NOTA_CREDITO']?.toString(),
      rucEmpresa: json['RUC_EMPRESA'].toString(),
      direccionEmpresa: json['DIRECCION_EMPRESA'].toString(),
      telefonoEmpresa: json['TELEFONO_EMPRESA'].toString(),
      webEmpresa: json['WEB_EMPRESA'].toString(),
      resultadoEnvio: json['RESULTADO_ENVIO'].toString(),
      idPago: json['Id_Pago'].toString(),
      formaPago: json['FORMA_PAGO'].toString(),
      fVcto: json['F_vcto'].toString(),
      importeCuota: json['IMPORTE_CUOTA'].toString(),
      nroCuotas: json['NroCuotas'].toString(),
      idBancoDet: json['ID_BANCO_DET'].toString(),
      idCuentaDet: json['ID_CUENTA_DET'].toString(),
      idBienes: json['ID_BIENES'].toString(),
      idMedioPago: json['ID_MEDIO_PAGO'].toString(),
      porcentajeDet: json['PORCENTAJE_DET'].toString(),
      importeDet: json['IMPORTE_DET'].toString(),
      idCuenta: json['ID_CUENTA'].toString(),
      observacionesDet: json['OBSERVCACIONES'].toString(),
      flagDetraccion: json['FLAG_DETRACCION'].toString(),
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
      'FLAG_DETRACCION': flagDetraccion,
    };
  }
}
