import 'package:bannet_movil_t/src/View/Comprobante/ComprobanteScreen.dart';
import 'package:bannet_movil_t/src/View/Home/IndexScreen.dart';
import 'package:bannet_movil_t/src/View/LibroReclamaciones/LibroReclamacionesScreen.dart';
import 'package:bannet_movil_t/src/View/PostVenta/PostVentaScreen.dart';
import 'package:bannet_movil_t/src/View/Profile/profileScreen.dart';
import 'package:bannet_movil_t/src/View/Recibo/ReciboScreen.dart';
import 'package:bannet_movil_t/src/View/SolicitudBaja/SolicitudBajaScreen.dart';
import 'package:bannet_movil_t/src/View/ZonaGamer/ZonaGamerScreen.dart';
import 'package:flutter/material.dart';

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
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_bannet_1.png',
                    width: 150,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¿Qué quieres hacer hoy?',
                    style: TextStyle(color: Color(0xFFA5CD39), fontSize: 20),
                  ),
                ],
              ),
            ),

            // Sección de opciones principales
            _buildDrawerSection([
              _buildDrawerItem(Icons.home, 'Inicio', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Indexscreen()));
              }),
              _buildDrawerItem(Icons.receipt, 'Recibos de Servicios', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReciboScreen()));
              }),
              _buildDrawerItem(Icons.assignment, 'Comprobantes', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ComprobanteScreen()));
              }),
              _buildDrawerItem(Icons.cancel_outlined, 'Solicitud de Baja', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SolicitudBajaScreen()));
              }),
              _buildDrawerItem(Icons.support_agent, 'Servicios PostVenta', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostVentaScreen()));
              }),
              _buildDrawerItem(Icons.videogame_asset, 'Zona Gamer', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ZonaGamerScreen()));
              }),
              _buildDrawerItem(Icons.menu_book, 'Libro de Reclamaciones', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LibroReclamacionesScreen()));
              }),
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

            ListTile(
              leading: Icon(Icons.fingerprint),
              title: Text(
                'Contraseña única',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Aprueba transacciones de manera segura',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Nuevo',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              onTap: () {
                // Acción del ítem
              },
            ),

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
