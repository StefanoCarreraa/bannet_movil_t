import 'dart:ui';

import 'package:bannet_movil_t/ReciboScreen.dart';
import 'package:bannet_movil_t/profileScreen.dart';
import 'package:flutter/material.dart';

class MiReciboScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color grisFondo = Color(0xFFF5F5F5);
  final Color grisOscuro = Color(0xFF333333);
  final Color negro = Color(0xFF000000);

  MiReciboScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grisFondo,
      appBar: AppBar(
        backgroundColor: negro,
        iconTheme: IconThemeData(color: verdeLima),
        title: Center(
          child: Image.asset(
            'assets/images/logo_bannet_1.png',
            height: 30,
          ),
        ),
        toolbarHeight: 60,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh, color: verdeLima),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: _buildCardNumeroAppBar(),
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner promocional
            _buildBannerPromo(),
            // // Mis consumos
            // _buildMisConsumos(),
            // Mi recibo
            _buildMiRecibo(),
            // Accesos directos
            _buildAccesosDirectos(),
          ],
        ),
      ),
      // Navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: verdeLima,
        unselectedItemColor: grisOscuro,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Recibo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_edu), label: 'Comprobantes'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.store_mall_directory), label: 'Tienda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports), label: 'Gamer'),
        ],
      ),
    );
  }

  Widget _buildCardNumeroAppBar() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: verdeLima),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stefano Carrera',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Cliente: Gamer',
                    style: TextStyle(fontSize: 14, color: grisOscuro),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_drop_down, color: verdeLima),
        ],
      ),
    );
  }

  // Banner promocional
  Widget _buildBannerPromo() {
    return Container(
      margin: EdgeInsets.all(12),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: verdeLima,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/images/img2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // // Mis consumos
  // Widget _buildMisConsumos() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
  //         child: Text('Mis consumos',
  //             style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //                 color: grisOscuro)),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           _buildConsumoCard('Datos Libres', '100 GB', verdeLima),
  //           _buildConsumoCard('Datos en Alta Velocidad', '82.6 GB', verdeLima),
  //           _buildConsumoCard('Datos en Alta Velocidad', '82.6 GB', verdeLima),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildConsumoCard(String titulo, String cantidad, Color color) {
  //   return Card(
  //     elevation: 2,
  //     child: Container(
  //       width: 150,
  //       padding: EdgeInsets.all(12),
  //       child: Column(
  //         children: [
  //           Text(titulo, style: TextStyle(fontSize: 14, color: Colors.black54)),
  //           SizedBox(height: 10),
  //           CircularProgressIndicator(
  //             value: 0.8, // Cambiar el progreso según corresponda
  //             color: color,
  //             backgroundColor: Colors.grey.shade300,
  //           ),
  //           SizedBox(height: 8),
  //           Text(cantidad, style: TextStyle(fontWeight: FontWeight.bold)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildMiRecibo() {
    return Card(
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.receipt_long_outlined, color: grisOscuro),
                SizedBox(width: 8),
                Text(
                  '¿Qué quieres hacer hoy?',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: grisOscuro),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBoton('Ver recibo', Colors.white, grisOscuro, true),
                SizedBox(width: 20),
                _buildBoton('Pagar', verdeLima, Colors.white, true),
              ],
            ),
          ],
        ),
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
                  ? BorderSide(color: grisOscuro, width: 2)
                  : BorderSide.none,
            ),
          ),
          onPressed: () {
            if (texto == 'Ver recibo') {
              // Navegar a la pantalla del recibo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReciboScreen()),
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

  // Accesos directos
  Widget _buildAccesosDirectos() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
          _buildAccesoCard(
              'Recibos de Servicios', Icons.receipt_long), // Recibos
          _buildAccesoCard(
              'Comprobantes', Icons.local_shipping), // Comprobantes
          _buildAccesoCard(
              'Solicitud de Baja', Icons.cancel), // Solicitud de baja
          _buildAccesoCard(
              'Servicios PostVenta', Icons.headset_mic), // Soporte técnico
          _buildAccesoCard('Zona Gamer', Icons.sports_esports), // Zona Gamer
          _buildAccesoCard('Libro de Reclamaciones', Icons.book),
        ],
      ),
    );
  }

  Widget _buildAccesoCard(String titulo, IconData icon) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: verdeLima),
            SizedBox(height: 10),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: grisOscuro),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Encabezado del Drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_bannet_2.png',
                    width: 150,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¿Qué quieres hacer hoy?',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),

            // Sección de opciones principales
            _buildDrawerSection([
              _buildDrawerItem(
                  Icons.receipt_long, 'Recibos de Servicios', () {}),
              _buildDrawerItem(Icons.local_shipping, 'Comprobantes', () {}),
              _buildDrawerItem(Icons.cancel, 'Solicitud de Baja', () {}),
              _buildDrawerItem(Icons.headset_mic, 'Servicios PostVenta', () {}),
              _buildDrawerItem(Icons.sports_esports, 'Zona Gamer', () {}),
              _buildDrawerItem(Icons.book, 'Libro de Reclamaciones', () {}),
            ]),

            _buildSectionTitle('MI CUENTA'),
            _buildDrawerItem(Icons.receipt, 'Detalles de mi plan', () {}),

            // Aquí hacemos que "Mi Perfil" abra ProfileScreen
            _buildDrawerItem(Icons.account_circle, 'Mi Perfil', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            }),

            // ListTile(
            //   leading: Icon(Icons.fingerprint),
            //   title: Text('Contraseña única'),
            //   subtitle: Text('Aprueba transacciones de manera segura'),
            //   trailing: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            //     decoration: BoxDecoration(
            //       color: Colors.pink,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Text(
            //       'Nuevo',
            //       style: TextStyle(color: Colors.white, fontSize: 12),
            //     ),
            //   ),
            //   onTap: () {
            //     // Acción del ítem
            //   },
            // ),

            // _buildSectionTitle('SERVICIOS'),
            // _buildDrawerItem(Icons.shopping_cart, 'Tienda'),
            // _buildDrawerItem(Icons.shopping_bag, 'Comprar paquetes'),
            // _buildDrawerItem(Icons.airplanemode_active, 'Comprar roaming'),

            // _buildSectionTitle('SOPORTE'),
            // _buildDrawerItem(Icons.build, 'Autogestión de averías'),
            // _buildDrawerItem(Icons.note, 'Solicitudes de mi línea'),
            SizedBox(height: 25),
            Divider(),
            SizedBox(height: 25),
            // Botón de cerrar sesión
            ListTile(
              leading: Icon(Icons.logout,
                  color: Colors.red), // Icono de cerrar sesión
              title: Center(
                child: Text(
                  'Cerrar sesión',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerSection(List<Widget> items) {
    return Column(
      children: items,
    );
  }

  // Widget para construir un ítem del Drawer con una función onTap
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xFFA5CD39),
      ),
      title: Text(
        title,
        style: TextStyle(color: Color(0xFFFFFFFF)),
      ),
      onTap: onTap,
    );
  }

  // Widget para las secciones con título
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
