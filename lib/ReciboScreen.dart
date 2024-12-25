import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReciboScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color blanco = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco, // Fondo blanco
      appBar: AppBar(
        title: Text('Mi recibo Bantel',
            style: TextStyle(color: Colors.black87)),
        backgroundColor: verdeLima, // Verde lima
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: blanco, // Fondo blanco
        selectedItemColor: verdeLima, // Verde lima para ítem activo
        unselectedItemColor: Colors.black54, // Gris oscuro para ítems inactivos
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment_outlined),
            activeIcon: Icon(Icons.apartment),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
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
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87)),
        subtitle: Text(
          '¡Bienvenido a Bantel! Este es tu nuevo plan',
          style: TextStyle(color: Colors.black54),
        ),
        trailing: Text('S/ 69.90',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
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
            title: Text('Descuento',
                style: TextStyle(color: Colors.black87)),
            trailing: Text('S/ -3.50',
                style: TextStyle(fontSize: 16, color: Colors.redAccent)),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.money_off, color: verdeLima),
            title: Text('Devoluciones',
                style: TextStyle(color: Colors.black87)),
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
                          style:
                              TextStyle(fontSize: 12, color: Colors.black54),
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
                            style: TextStyle(
                                fontSize: 14, color: Colors.black54),
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