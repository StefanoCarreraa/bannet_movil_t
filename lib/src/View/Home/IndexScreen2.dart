import 'package:bannet_movil_t/src/widget/DrawerSectionCustom.dart';
import 'package:flutter/material.dart';

class BienvenidaScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color grisFondo = Color(0xFFF5F5F5);
  final Color grisOscuro = Color(0xFF333333);
  final Color negro = Color(0xFF000000);

  BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: negro,
        iconTheme: IconThemeData(color: verdeLima),
        title: Center(
          child: Image.asset(
            'assets/images/logo_bannet_1.png',
            height: 30,
          ),
        ),
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh, color: verdeLima),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Contenedor con Stack para Imagen y Texto
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                child: SizedBox(
                  height: 80, // Altura ajustable
                  child: Stack(
                    children: [
                      // Imagen de fondo
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/barra_degrade.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Texto superpuesto
                      Positioned(
                        left: 35,
                        top: 28,
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
              ),
              const SizedBox(height: 30),

              // Plan de Internet
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tu Plan:',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // Estira todos los elementos a la misma altura
                  children: [
                    planItem('Internet 100Mbps'),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    planItem('1 cuenta streaming\nBantel tv+'),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Precio centrado
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    's/ 55 mensuales',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Estado e Información
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    estadoItem('Estado:', 'Activo'),
                    Container(
                      height: 50,
                      width: 2,
                      color: verdeLima,
                    ),
                    iconItem('HD', 'Resolución HD'),
                    iconItem('4', 'Pantallas simultáneas'),
                    iconItem('🔗', 'Multi-dispositivo'),
                  ],
                ),
              ),
              const Spacer(),

              // // Botón WhatsApp
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: FloatingActionButton(
              //     backgroundColor: Colors.green,
              //     onPressed: () {
              //       // Acción para abrir WhatsApp
              //     },
              //     child: const Icon(Icons.tiktok, color: Colors.white),
              //   ),
              // ),
            ],
          ),
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

  Widget planItem(String text) {
    return Container(
      width: 140, // Ajusta un ancho fijo si es necesario
      height: 60, // Altura fija para ambos contenedores
      alignment: Alignment.center, // Asegura que el texto esté centrado
      decoration: BoxDecoration(
        color: verdeLima,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget estadoItem(String title, String status) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        const SizedBox(height: 5),
        Text(
          status,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget iconItem(String icon, String text) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
