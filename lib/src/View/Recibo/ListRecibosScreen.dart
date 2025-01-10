import 'package:bannet_movil_t/src/widget/TaskCardWidget.dart';
import 'package:flutter/material.dart';

class Listrecibosscreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color blanco = Color(0xFFFFFFFF);
  final Color negro = Color(0xFF000000);

  Listrecibosscreen({super.key});

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
                  "Mis recibos",
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
                  titulo: 'Nro. Recibo : 000000000598866',
                  subtitulo:
                      'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                  periodo: 'Periodo: 2025-ENERO',
                  precio: 'Monto : S/. 35.00',
                  color: verdeLima,
                  isCompleted: false),
              TaskCardWidget(
                  titulo: 'Nro. Recibo : 000000000598866',
                  subtitulo:
                      'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                  periodo: 'Periodo: 2025-ENERO',
                  precio: 'Monto : S/. 55.00',
                  color: verdeLima,
                  isCompleted: false),
              TaskCardWidget(
                  titulo: 'Nro. Recibo : 000000000598866',
                  subtitulo:
                      'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                  periodo: 'Periodo: 2025-ENERO',
                  precio: 'Monto : S/. 65.00',
                  color: verdeLima,
                  isCompleted: false),
              SizedBox(height: 30),
              Divider(
                color: verdeLima,
                thickness: 1,
              ),
              SizedBox(height: 20),
              _buildMontoPagarCard(
                titulo: "Monto a pagar",
                monto: "S/. 155.00",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMontoPagarCard({required String titulo, required String monto}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.attach_money, color: verdeLima, size: 36),
        title: Text(
          titulo,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: negro),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              monto,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: verdeLima),
            ),
          ],
        ),
      ),
    );
  }
}
