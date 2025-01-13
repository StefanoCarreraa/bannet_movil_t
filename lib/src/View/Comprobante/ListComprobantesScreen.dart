import 'package:bannet_movil_t/src/View/Comprobante/ComprobanteScreen.dart';
import 'package:bannet_movil_t/src/widget/TaskCardWidget.dart';
import 'package:flutter/material.dart';

class Listcomprobantesscreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color blanco = Color(0xFFFFFFFF);
  final Color negro = Color(0xFF000000);

  Widget _buildMiRecibo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.receipt_long_outlined, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                '¿Qué quieres hacer hoy?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoton('Descargar Comprobante', Colors.white, negro, true),
              // SizedBox(width: 20),
              // _buildBoton('Pagar', verdeLima, Colors.white, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoton(
      String texto, Color colorFondo, Color colorTexto, bool conBorde) {
    return Builder(
      builder: (BuildContext context) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colorFondo,
            foregroundColor: colorTexto,
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: conBorde
                  ? BorderSide(color: Colors.black12, width: 2)
                  : BorderSide.none,
            ),
          ),
          onPressed: () {
            if (texto == 'Descargar Comprobante') {
              // Navegar a la pantalla del recibo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Comprobantescreen()),
              );
            } else {
              print("Botón presionado: $texto");
            }
          },
          child: Text(
            texto,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        );
      },
    );
  }

  Listcomprobantesscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco, // Fondo blanco
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_bannet_1.png',
          height: 30,
        ),
        toolbarHeight: 60,
        backgroundColor: negro,
        centerTitle: true, // Garantiza que el título esté centrado
        iconTheme: IconThemeData(color: verdeLima),
      ),
      body: Container(
        constraints:
            BoxConstraints.expand(), // Ocupa todo el espacio disponible

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/Bannet_Fond.jpg'), // Reemplaza con tu imagen
            fit: BoxFit.cover,
          ),
          color: Color(0xFF000000),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Comprobantes",
                  style: TextStyle(
                      color: verdeLima,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TaskCardWidget(
                titulo: 'Nro. Comprobante : 000000000598866',
                subtitulo: 'Tipo Comprobante: BOLETA DE VENTA ELECTRONICA',
                // periodo: 'Periodo: 2025-ENERO',
                fecha: 'Fecha: 21/09/2024',
                precio: 'Monto : S/. 35.00',
                color: verdeLima,
                isCompleted: false,
                expandedContent: _buildMiRecibo(),
              ),
              TaskCardWidget(
                titulo: 'Nro. Comprobante : 000000000598866',
                subtitulo: 'Tipo Comprobante: BOLETA DE VENTA ELECTRONICA',
                // periodo: 'Periodo: 2025-ENERO',
                fecha: 'Fecha: 21/09/2024',
                precio: 'Monto : S/. 35.00',
                color: verdeLima,
                isCompleted: false,
                expandedContent: _buildMiRecibo(),
              ),
              TaskCardWidget(
                titulo: 'Nro. Comprobante : 000000000598866',
                subtitulo: 'Tipo Comprobante: BOLETA DE VENTA ELECTRONICA',
                // periodo: 'Periodo: 2025-ENERO',
                fecha: 'Fecha: 21/09/2024',
                precio: 'Monto : S/. 35.00',
                color: verdeLima,
                isCompleted: false,
                expandedContent: _buildMiRecibo(),
              ),
              SizedBox(height: 30),
              Divider(
                color: verdeLima,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
