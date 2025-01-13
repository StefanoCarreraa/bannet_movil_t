import 'dart:ui';

import 'package:bannet_movil_t/src/View/Comprobante/ListComprobantesScreen.dart';
import 'package:bannet_movil_t/src/View/Profile/profileScreen.dart';
import 'package:bannet_movil_t/src/View/Recibo/ListRecibosScreen.dart';
import 'package:bannet_movil_t/src/View/Recibo/ReciboScreen.dart';
import 'package:bannet_movil_t/src/View/ZonaGamer/ZonaGamerScreen.dart';
import 'package:bannet_movil_t/src/widget/AlertshowModalBottomSheet.dart';
import 'package:bannet_movil_t/src/widget/DrawerSectionCustom.dart';
import 'package:bannet_movil_t/src/widget/TaskCardWidget.dart';
import 'package:flutter/material.dart';

class Indexscreen extends StatefulWidget {
  Indexscreen({super.key});

  @override
  State<Indexscreen> createState() => _IndexscreenState();
}

class _IndexscreenState extends State<Indexscreen> {
  final Color verdeLima = Color(0xFFA5CD39);

  final Color grisFondo = Color(0xFFF5F5F5);

  final Color grisOscuro = Color(0xFF333333);

  final Color negro = Color(0xFF000000);
  bool _isExpanded = true;

  int _selectedIndex = 0;

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
    void _onItemTapped(int index) {
      _selectedIndex = index;

      if (index == 1) {
        // Cuando se selecciona el ítem "Recibo"
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Listrecibosscreen()),
        );
      }
      if (index == 2) {
        // Cuando se selecciona el ítem "Recibo"
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Listcomprobantesscreen()),
        );
      }
      if (index == 3) {
        // Cuando se selecciona el ítem "Recibo"
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ZonaGamerScreen()),
        );
      }
    }

    return Scaffold(
      backgroundColor: grisFondo,
      appBar: AppBar(
        backgroundColor: negro,
        iconTheme: IconThemeData(color: verdeLima),
        title: Center(
          child: Image.asset(
            'assets/images/logo_miportal.png',
            height: 55,
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
      body: Stack(
        children: [
          Container(
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
                _buildBannerUsuario(),
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
              ],
            ),
          ),
          // Botón flotante encima del BottomNavigationBar
          Positioned(
            bottom: 10, // Posición base
            left: _isExpanded ? 16 : 16, // Siempre a la izquierda
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // Animación suave
              width: _isExpanded ? MediaQuery.of(context).size.width - 32 : 60,
              height: _isExpanded
                  ? 200
                  : 60, // Usa una altura fija cuando se expanda
              padding: _isExpanded ? EdgeInsets.all(20) : EdgeInsets.zero,
              decoration: BoxDecoration(
                color:
                    _isExpanded ? grisOscuro : Colors.white, // Fondo ajustado
                borderRadius: BorderRadius.circular(_isExpanded ? 12 : 8),
                border: Border.all(
                  color: verdeLima, // Color del borde verde
                  width: 2,
                ),
              ),
              child: _isExpanded
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Métodos de Pago",
                                style: TextStyle(
                                  color: verdeLima,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: verdeLima,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20), // Espacio entre título y botones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: FloatingActionButton(
                                heroTag: 'button1',
                                onPressed: () {
                                  // Acción del primer botón
                                },
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/logo/Versión-Móvil_BBVA-16.png', // Reemplaza con tu imagen
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: FloatingActionButton(
                                heroTag: 'button2',
                                onPressed: () {
                                  // Acción del segundo botón
                                },
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/logo/Versión-Móvil_BCP-17.png', // Reemplaza con tu imagen
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: FloatingActionButton(
                                heroTag: 'button3',
                                onPressed: () {
                                  // Acción del tercer botón
                                },
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/logo/Versión-Móvil_Yape-Logo.png', // Reemplaza con tu imagen
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Icon(
                        Icons.payment,
                        color: verdeLima,
                        size: 40,
                      ),
                    ),
            ),
          )
        ],
      ),
      // Navegación inferior
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: negro, // Fondo negro de la barra de navegación
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white, // Elementos seleccionados en blanco
          unselectedItemColor:
              Colors.grey, // Elementos no seleccionados en gris
          showUnselectedLabels: true,
          onTap: (index) {
            _onItemTapped(index); // Solo pasa el índice, no context
          },
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

  Widget _buildBotonImage(String assetPath, String tipo, Color colorFondo,
      Color colorTexto, bool conBorde) {
    return Builder(
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity, // Ocupa todo el ancho disponible

          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorFondo,
              foregroundColor: colorTexto,
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: conBorde
                    ? BorderSide(color: Colors.black12, width: 2)
                    : BorderSide.none,
              ),
            ),
            onPressed: () {
              if (tipo == 'BBVA') {
                // Navegar a la pantalla del recibo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReciboScreen()),
                );
              } else if (tipo == 'BCP') {
                // Navegar a la pantalla del recibo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReciboScreen()),
                );
              } else if (tipo == 'YAPE') {
                // Navegar a la pantalla del recibo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReciboScreen()),
                );
              }
            },
            child: Image.asset(
              assetPath, // Ruta de la imagen en tus assets
              width: 70, // Opcional: ajusta el ancho
              height: 50, // Opcional: ajusta la altura
            ),
          ),
        );
      },
    );
  }
}
