import 'dart:ui';

import 'package:bannet_movil_t/src/View/Profile/profileScreen.dart';
import 'package:bannet_movil_t/src/View/Recibo/ReciboScreen.dart';
import 'package:bannet_movil_t/src/widget/DrawerSectionCustom.dart';
import 'package:bannet_movil_t/src/widget/TaskCardWidget.dart';
import 'package:flutter/material.dart';

class Indexscreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color grisFondo = Color(0xFFF5F5F5);
  final Color grisOscuro = Color(0xFF333333);
  final Color negro = Color(0xFF000000);

  Indexscreen({super.key});
  void _mostrarConfirmacionCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar cierre de sesión'),
          content: Text('¿Está seguro de que desea cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                // Lógica para cerrar sesión
                print('Sesión cerrada');
              },
              child: Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

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
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.account_circle, color: verdeLima),
                onPressed: () {
                  final RenderBox appBarBox =
                      context.findRenderObject() as RenderBox;
                  final Offset position = appBarBox
                      .localToGlobal(Offset.zero); // Posición global del AppBar

                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      position.dx +
                          appBarBox.size.width -
                          60, // Ajusta la posición horizontal
                      position.dy +
                          appBarBox.size.height +
                          5, // Ajusta la posición vertical
                      0,
                      0,
                    ),
                    items: [
                      PopupMenuItem(
                        value: 'Perfil',
                        child: Row(
                          children: [
                            Icon(Icons.person, color: verdeLima),
                            SizedBox(width: 8),
                            Text('Perfil'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Cerrar sesión',
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              'Cerrar sesión',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(0), // Sin borde redondeado
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ).then((value) {
                    if (value != null) {
                      switch (value) {
                        case 'Perfil':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()),
                          );
                          break;
                        case 'Cerrar sesión':
                          _mostrarConfirmacionCerrarSesion(context);
                          break;
                      }
                    }
                  });
                },
              );
            },
          ),
        ],
      ),

      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/Bannet_Fond.jpg'), // Reemplaza con tu imagen
            fit: BoxFit.cover,
          ),
          color: Color(0xFF000000),
        ),
        child: Column(
          children: [
            // Banner promocional
            // _buildBannerPromo(),
            //Banner Usuario
            _buildBannerUsuario(),
            // SizedBox(height: 15),

            // // Mi recibo
            // _buildMiRecibo(),
            SizedBox(height: 20),

            //
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      "Planes",
                      style: TextStyle(
                          color: verdeLima,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  TaskCardWidget(
                      titulo:
                          'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                      precio: 'Monto : S/. 35.00',
                      fecha: 'Inicio de facturación : 21/08/2024',
                      color: verdeLima,
                      isCompleted: false),
                  TaskCardWidget(
                      titulo:
                          'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                      precio: 'Monto : S/. 55.00',
                      fecha: 'Inicio de facturación : 21/08/2024',
                      color: verdeLima,
                      isCompleted: false),
                  TaskCardWidget(
                      titulo:
                          'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                      precio: 'Monto : S/. 65.00',
                      fecha: 'Inicio de facturación : 21/08/2024',
                      color: verdeLima,
                      isCompleted: false),
                ],
              ),
            ),

            // Accesos directos
            // _buildAccesosDirectos(),
          ],
        ),
      ),
      // Navegación inferior
      bottomNavigationBar: Theme(
        data: ThemeData(
          // Forzamos el color negro de fondo para el BottomNavigationBar
          canvasColor:
              negro, // Específicamente el fondo de la barra de navegación
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

  Widget _buildBannerUsuario() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // Bordes redondeados
      child: SizedBox(
        height: 130, // Altura ajustable
        child: Stack(
          children: [
            // Imagen de fondo, alineada a la derecha
            Positioned.fill(
              child: Image.asset(
                'assets/images/barra_degrade.png',
                fit: BoxFit
                    .cover, // Cubrir el área disponible sin cambiar el tamaño
                alignment: Alignment.centerRight, // Alineación a la derecha
              ),
            ),
            // Texto superpuesto
            Positioned(
              left: 35,
              top: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bienvenida,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Johana Caceda',
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

  // Widget _buildMiRecibo() {
  //   return Card(
  //     margin: EdgeInsets.all(12),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Icon(Icons.receipt_long_outlined, color: grisOscuro),
  //               SizedBox(width: 8),
  //               Text(
  //                 '¿Qué quieres hacer hoy?',
  //                 style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                     color: grisOscuro),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 20),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               _buildBoton('Ver recibos', Colors.white, grisOscuro, true),
  //               SizedBox(width: 20),
  //               _buildBoton('Pagar', verdeLima, Colors.white, true),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBoton(
  //     String texto, Color colorFondo, Color colorTexto, bool conBorde) {
  //   return Builder(
  //     builder: (BuildContext context) {
  //       return TextButton(
  //         style: TextButton.styleFrom(
  //           backgroundColor: colorFondo,
  //           foregroundColor: colorTexto,
  //           padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(8),
  //             side: conBorde
  //                 ? BorderSide(color: grisOscuro, width: 2)
  //                 : BorderSide.none,
  //           ),
  //         ),
  //         onPressed: () {
  //           if (texto == 'Ver recibos') {
  //             // Navegar a la pantalla del recibo
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => ReciboScreen()),
  //             );
  //           } else {
  //             print("Botón presionado: $texto");
  //           }
  //         },
  //         child: Text(
  //           texto,
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //         ),
  //       );
  //     },
  //   );
  // }

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

  // Widget _buildTaskCard({
  //   required String titulo,
  //   required String fecha,
  //   required String precio,
  //   required Color color,
  //   required bool isCompleted,
  // }) {
  //   return Container(
  //     width: double.infinity, // Asegura que use el espacio disponible

  //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[900],
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Row(
  //       children: [
  //         // Borde de color a la izquierda
  //         Container(
  //           width: 8,
  //           height: 130,
  //           decoration: BoxDecoration(
  //             color: color,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(12),
  //               bottomLeft: Radius.circular(12),
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 16),
  //         // Información de la tarea
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 titulo,
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 4),
  //               Row(
  //                 children: [
  //                   Icon(Icons.calendar_today, size: 14, color: Colors.white54),
  //                   SizedBox(width: 4),
  //                   Text(
  //                     precio,
  //                     style: TextStyle(color: Colors.white54),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 4),
  //               Row(
  //                 children: [
  //                   Icon(Icons.calendar_today, size: 14, color: Colors.white54),
  //                   SizedBox(width: 4),
  //                   Text(
  //                     fecha,
  //                     style: TextStyle(color: Colors.white54),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //         // Icono de estado
  //         Padding(
  //           padding: const EdgeInsets.only(right: 16.0),
  //           child: Icon(
  //             isCompleted
  //                 ? Icons.check_circle_rounded
  //                 : Icons.radio_button_unchecked,
  //             color: isCompleted ? Colors.purpleAccent : Colors.white54,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
