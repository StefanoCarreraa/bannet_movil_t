import 'package:bannet_movil_t/src/Models/comprobanteImpresion_model.dart';
import 'package:bannet_movil_t/src/Services/pdfComprobante_service.dart';
import 'package:flutter/material.dart';

class PdfdescargasController extends ChangeNotifier {
  PdfDescargarService pdfDescargarService = PdfDescargarService();

  Future<List<String?>> descargarPDF(
      List<ComprobanteImpresionModel> item, int idPersona) async {
    List<String?> filePaths = [];
    try {
      var nota = '';

      var detraccion = item[0].flagDetraccion == 'true';

      if (item[0].idDocumento == "301") {
        // filePaths =
        //     await pdfDescargarService.descargarPdfComprobanteBoleta([item[0]]);
        filePaths = [
          ...await pdfFactura([item[0]], detraccion)
        ];
      } else if (item[0].idDocumento == "303") {
        filePaths = [
          ...await pdfBoleta([item[0]])
        ];
      } else if (item[0].idDocumento == "307" || item[0].idDocumento == "315") {
        nota = item[0].idDocumento == "307" ? 'CRÉDITO' : 'DÉBITO';
        filePaths = [
          (await pdfCreddebi([item[0]], nota)).first
        ];
      }
    } catch (error) {
      debugPrint('Error al descargar PDF: $error');
    }
    return filePaths;
  }

  Future<List<String?>> pdfFactura(
      List<ComprobanteImpresionModel> reciboimpresionModel,
      bool detraccion) async {
    List<String?> filePaths = await pdfDescargarService
        .descargarPdfComprobanteFactura([reciboimpresionModel[0]]);
    return filePaths;
  }

  Future<List<String?>> pdfBoleta(
      List<ComprobanteImpresionModel> reciboimpresionModel) async {
    List<String?> filePaths = await pdfDescargarService
        .descargarPdfComprobanteBoleta([reciboimpresionModel[0]]);
    return filePaths;
  }

  Future<List<String?>> pdfCreddebi(
      List<ComprobanteImpresionModel> reciboimpresionModel, String nota) async {
    List<String?> filePaths = await pdfDescargarService
        .descargarPdfComprobanteCreddebi([reciboimpresionModel[0]]);
    return filePaths;
  }
}
