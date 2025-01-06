import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReciboScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color blanco = Color(0xFFFFFFFF);
  final Color negro = Color(0xFF000000);

  ReciboScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco, // Fondo blanco
      appBar: AppBar(
        title: Text('Mis recibos Bantel', style: TextStyle(color: verdeLima)),
        backgroundColor: negro, // Verde lima
        centerTitle: true,
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
              _buildResumenCuenta(),
              SizedBox(height: 20),
              _buildPlanAdicionales(),
              SizedBox(height: 20),
              _buildMontosDescontados(),
              SizedBox(height: 20),
              _buildEvolutivoMensual(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          // Forzamos el color negro de fondo para el BottomNavigationBar
          canvasColor: Colors
              .black, // Específicamente el fondo de la barra de navegación
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white, // Elementos seleccionados en blanco
          unselectedItemColor:
              Colors.grey, // Elementos no seleccionados en gris
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: 'Recibo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_edu),
              label: 'Comprobantes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports),
              label: 'Gamer',
            ),
          ],
        ),
      ),
    );
  }

  // Widget Resumen de cuenta
  Widget _buildResumenCuenta() {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: verdeLima),
                SizedBox(width: 8),
                Text('Pagado',
                    style: TextStyle(color: verdeLima, fontSize: 18)),
                Spacer(),
                Text('S/ 50.00',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            _buildText('Vencimiento: 17 de octubre'),
            _buildText('Código de pago: 931910448'),
            _buildText('Renovación: 01 de cada mes'),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.black87),
    );
  }

  // Widget Plan y Adicionales
  Widget _buildPlanAdicionales() {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.all(12),
      child: ListTile(
        leading: Icon(Icons.phone_android, color: verdeLima),
        title: Text('Plan Ilimitado Bantel',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        subtitle: Text(
          '¡Bienvenido a Bantel! Este es tu nuevo plan',
          style: TextStyle(color: Colors.black54),
        ),
        trailing: Text('S/ 69.90',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ),
    );
  }

  // Widget Montos descontados
  Widget _buildMontosDescontados() {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.percent, color: verdeLima),
            title: Text('Descuento', style: TextStyle(color: Colors.black87)),
            trailing: Text('S/ -3.50',
                style: TextStyle(fontSize: 16, color: Colors.redAccent)),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.money_off, color: verdeLima),
            title:
                Text('Devoluciones', style: TextStyle(color: Colors.black87)),
            trailing: Text('S/ -63.00',
                style: TextStyle(fontSize: 16, color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  // Widget Evolutivo Mensual
  Widget _buildEvolutivoMensual() {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Evolutivo mensual',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: _getBarGroups(),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          'S/ ${value.toInt()}',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['Ago', 'Sep', 'Oct'];
                          return Text(
                            months[value.toInt()],
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    final List<double> gastos = [120.0, 90.0, 150.0];
    return List.generate(
      gastos.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: gastos[index],
            color: verdeLima,
            width: 18,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
