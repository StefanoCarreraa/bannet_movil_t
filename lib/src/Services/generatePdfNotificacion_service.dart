import 'dart:io';
import 'dart:typed_data';
import 'package:bannet_movil_t/src/Models/reciboImpresion_model%20.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PdfService {
  Future<void> generatePdfNotificacion(List<ReciboimpresionModel> data) async {
    final pdf = pw.Document();

    // Cargar logo desde assets
    final ByteData bytes =
        await rootBundle.load('assets/logo/Versión-Móvil_BBVA-16.png');
    final Uint8List logo = bytes.buffer.asUint8List();

    // Obtener fecha actual
    final DateTime fecha = DateTime.now();
    final String fechaActual =
        "${fecha.year}${fecha.month.toString().padLeft(2, '0')}${fecha.day.toString().padLeft(2, '0')}";

    double total = 0;

    // Construcción de la tabla
    List<pw.TableRow> rows = [
      // Cabecera de la tabla
      pw.TableRow(
        decoration: pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(width: 1))),
        children: [
          _tableHeader("F. Emisión"),
          _tableHeader("Nro.Recibo"),
          _tableHeader("Período"),
          _tableHeader("Descripción Servicio/Plan"),
          _tableHeader("F.Vcto"),
          _tableHeader("Importe"),
        ],
      ),
    ];

    // Filas de datos
    for (var det in data) {
      total += det.importe;
      rows.add(
        pw.TableRow(
          children: [
            _tableCell(det.fechaEmision ?? ""),
            _tableCell(det.numDocumento),
            _tableCell(det.periodo),
            _tableCell(det.itemDescripcion ?? ""),
            _tableCell(det.fechaVencimiento ?? ""),
            _tableCell(det.importe.toStringAsFixed(2), isBold: true),
          ],
        ),
      );
    }

    // Creación del PDF
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(26.5),
        header: (context) => _buildHeader(logo, data[0]),
        footer: (context) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Página ${context.pageNumber} / ${context.pagesCount}',
            style: pw.TextStyle(fontSize: 10),
          ),
        ),
        build: (context) => [
          _buildClientInfo(data[0]),
          pw.SizedBox(height: 10),
          pw.Table(border: pw.TableBorder.all(), children: rows),
          pw.SizedBox(height: 20),
          _buildTotalSection(total, data[0].simboloMoneda),
        ],
      ),
    );

    // Guardar archivo en almacenamiento temporal
    final Directory tempDir = await getTemporaryDirectory();
    final String filePath = "${tempDir.path}/Notificacion_$fechaActual.pdf";
    final File file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Abrir PDF en vista previa
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'Notificacion_$fechaActual.pdf');
  }

  // 🔹 Encabezado con logo y empresa en un solo cuadro
  pw.Widget _buildHeader(Uint8List logo, ReciboimpresionModel empresa) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(pw.MemoryImage(logo), width: 100, height: 75),
            pw.Container(
              width: 159,
              padding: pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text("R.U.C: ${empresa.rucEmpresa}",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 11)),
                  pw.Text(empresa.descripcion,
                      style: pw.TextStyle(fontSize: 11)),
                  pw.Text("Nro: ${empresa.numDocumento}",
                      style: pw.TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Text("${empresa.direccionEmpresa} - Tel: ${empresa.telefonoEmpresa}",
            style: pw.TextStyle(fontSize: 10)),
        // pw.Divider(),
      ],
    );
  }

  // 🔹 Información del cliente
  pw.Widget _buildClientInfo(ReciboimpresionModel cliente) {
    return pw.Table(
      columnWidths: {0: pw.FlexColumnWidth(1), 1: pw.FlexColumnWidth(9)},
      children: [
        _infoRow("Cliente:", cliente.persona),
        _infoRow(cliente.documento, cliente.dni),
        _infoRow("Dirección:", cliente.direccion),
        _infoRow("Emisión:", cliente.fechaEmision ?? ""),
      ],
    );
  }

  // 🔹 Sección de total
  pw.Widget _buildTotalSection(double total, String moneda) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text("Total Pendiente: $moneda",
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(width: 10),
        pw.Text(total.toStringAsFixed(2),
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _tableHeader(String text) => pw.Container(
        padding: pw.EdgeInsets.all(5),
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        alignment: pw.Alignment.center, // 🔹 Centra el contenido en la celda
        child: pw.Text(
          text,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8.5),
          textAlign: pw.TextAlign.center, // 🔹 Centra el texto
        ),
      );

  pw.Widget _tableCell(String text, {bool isBold = false}) => pw.Container(
        padding: pw.EdgeInsets.all(5),
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        child: pw.Text(text,
            style: pw.TextStyle(
                fontSize: 8,
                fontWeight:
                    isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
      );

  // 🔹 Fila de información del cliente
  pw.TableRow _infoRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
            padding: pw.EdgeInsets.all(0),
            child: pw.Text(label,
                style: pw.TextStyle(
                    fontSize: 10, fontWeight: pw.FontWeight.bold))),
        pw.Padding(
            padding: pw.EdgeInsets.all(5),
            child: pw.Text(value, style: pw.TextStyle(fontSize: 10))),
      ],
    );
  }
}
