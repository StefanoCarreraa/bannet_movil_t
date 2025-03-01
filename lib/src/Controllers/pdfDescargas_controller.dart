import 'package:bannet_movil_t/src/Controllers/comprobante_controller.dart';
import 'package:bannet_movil_t/src/Models/comprobanteImpresion_model.dart';
import 'package:bannet_movil_t/src/Services/comprobante_service.dart';
import 'package:bannet_movil_t/src/Services/pdfComprobante_service.dart';
import 'package:flutter/material.dart';

class PdfdescargasController extends ChangeNotifier {
  PdfDescargarService pdfDescargarService = PdfDescargarService();
  Future<List<String?>> descargarPDF(
      List<ComprobanteImpresionModel> item, int idPersona) async {
    List<String?> filePaths = [];
    try {
      var nota = '';

      var detraccion = item[0].flagDetraccion;

      if (item[0].idDocumento == "301") {
        pdfFactura(item[0], detraccion == 1);

        filePaths =
            await pdfDescargarService.DescargarPdfComprobante([item[0]]);
        pdfDescargarService.DescargarPdfComprobante([item[0]]);
        debugPrint('Factura::: ${item[0]}');
      } else if (item[0].idDocumento == "303") {
        pdfBoleta(item[0]);
        debugPrint('Boleta::: ${item[0]}');
      } else if (item[0].idDocumento == "307" || item[0].idDocumento == "315") {
        nota = item[0].idDocumento == "307" ? 'CRÉDITO' : 'DÉBITO';
        pdfCreditoDebito(item[0], nota);
        debugPrint('Credito - Debito::: ${item[0]}');
      }
    } catch (error) {
      debugPrint('Error al descargar PDF: $error');
    }
    return filePaths;
  }

  void pdfFactura(dynamic data, bool detraccion) {
    // Lógica para procesar la factura
  }

  void pdfBoleta(dynamic data) {
    // Lógica para procesar la boleta
  }

  void pdfCreditoDebito(dynamic data, String nota) {
    // Lógica para procesar crédito/débito
  }
}
