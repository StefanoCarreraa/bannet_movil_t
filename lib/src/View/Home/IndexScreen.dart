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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();

  double _width = 0; // Variable para almacenar el largo del widget

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

  @override
  Widget build(BuildContext context) {
    // Calcular el tamaño del widget después de que se haya renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = _key1.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final size = renderBox.size;
        if (size.width > 0) {
          setState(() {
            _width = size.width; // Obtener el largo del widget
          });
        }
      }
    });
    return Scaffold(
      key: _key1, // Asignar un GlobalKey único

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
                image: AssetImage('assets/images/Bannet_Fond.jpg'),
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
                      // TaskCardWidget(
                      //     titulo:
                      //         'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                      //     precio: 'Monto : S/. 55.00',
                      //     fecha: 'Inicio de facturación : 21/08/2024',
                      //     color: verdeLima,
                      //     isCompleted: false),
                      // TaskCardWidget(
                      //     titulo:
                      //         'Plan : INTERNET 400 MBPS + 3 STREAMING PLAN FULL PRIME',
                      //     precio: 'Monto : S/. 65.00',
                      //     fecha: 'Inicio de facturación : 21/08/2024',
                      //     color: verdeLima,
                      //     isCompleted: false),
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
                  ? 150
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
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    // Permite que el texto se ajuste al espacio disponible
                                    child: Text(
                                      "Métodos de Pago",
                                      style: TextStyle(
                                        color: verdeLima,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Opcional: Agrega puntos suspensivos si es necesario
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
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: FloatingActionButton(
                                  heroTag: 'button1',
                                  onPressed: () {
                                    showBBVAModal(context);
                                  },
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/logo/Versión-Móvil_BBVA-16.png',
                                    height: 30,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: FloatingActionButton(
                                  heroTag: 'button2',
                                  onPressed: () {
                                    showBCPModal(context);
                                  },
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/logo/Versión-Móvil_BCP-17.png',
                                    height: 30,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: FloatingActionButton(
                                  heroTag: 'button3',
                                  onPressed: () {
                                    showYapeModal(context);
                                  },
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/logo/Versión-Móvil_Yape-Logo.png',
                                    height: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
    double adjustedHeight = _width < 615
        ? 180
        : 130; // Si el ancho es menor que 615, la altura será 200

    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // Bordes redondeados
      child: SizedBox(
        height: adjustedHeight, // Altura ajustable
        child: Stack(
          children: [
            // Imagen de fondo, alineada a la derecha
            Positioned.fill(
              child: Image.asset(
                'assets/images/barra_degrade.png',
                fit: BoxFit.cover,
                alignment: Alignment.centerRight, // Alineación a la derecha
              ),
            ),
            // Texto y widget superpuesto
            Positioned(
              left: 35,
              top: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
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
                  const SizedBox(height: 5),
                  _width < 615
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                "Stefano Manuel", // Mostrar todo el nombre si el ancho es suficiente
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
                              Text(
                                "Carrera Alvarado", // Mostrar todo el nombre si el ancho es suficiente
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
                            ])
                      : Text(
                          "Stefano Manuel Carrera Alvarado", // Mostrar todo el nombre si el ancho es suficiente
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

  void showYapeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Fondo transparente para el modal
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Borde blanco detrás del contenido
              borderRadius: BorderRadius.circular(
                  20.0), // Bordes redondeados para el modal
              border: Border.all(
                color: Colors.white, // Borde blanco
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  18.0), // Bordes internos ligeramente más pequeños
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Versión-Móvil_FONDO_Yape.png'), // Reemplaza con tu imagen
                    fit: BoxFit.cover,
                  ),
                ),
                child: DefaultTabController(
                  length: 3,
                  child: Wrap(
                    children: [
                      // Icono de cierre
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.timesCircle,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      // Contenido del modal
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo de Yape
                              Image.asset(
                                'assets/logo/Versión-Móvil_Yape-Blanco.png', // Reemplaza con la ruta de tu logo
                                height: 80,
                              ),
                              const SizedBox(height: 20),
                              // Título
                              const Text(
                                'PAGA TU RECIBO POR YAPE',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Texto blanco
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              // Instrucciones
                              Column(
                                children: [
                                  _buildStep(
                                    1,
                                    'Accede a "Yapear Servicios"',
                                    Colors.purple,
                                    Colors.white,
                                  ),
                                  _buildStep(
                                    2,
                                    'Digita el nombre "Bantel"',
                                    Colors.purple,
                                    Colors.white,
                                  ),
                                  _buildStep(
                                    3,
                                    'Selecciona la opción "Bantel Sac"',
                                    Colors.purple,
                                    Colors.white,
                                  ),
                                  _buildStep(
                                    4,
                                    'Digita número de DNI del titular Bantel',
                                    Colors.purple,
                                    Colors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showBCPModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/Versión-Móvil_FONDO_BCP.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: DefaultTabController(
                  length: 3,
                  child: Wrap(
                    children: [
                      // Icono de cierre
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.timesCircle,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      // Logo y título
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/logo/Versión-Móvil_BCP_blanco.png',
                                height: 60,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'PAGA TU RECIBO POR BCP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      // TabBar
                      TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey[400],
                        indicatorColor: Colors.white,
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: 16.0), // Ajusta el padding aquí
                        tabs: const [
                          Tab(text: 'Agente BCP'),
                          Tab(text: 'App BCP'),
                          Tab(text: 'Banca por Internet'),
                        ],
                      ),
                      // Contenido de las pestañas
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.5, // Máximo 50% de la pantalla
                        child: TabBarView(
                          children: [
                            _buildStepsSection([
                              'Acércate a un Agente BCP más cercana',
                              'Indica el nombre del convenio "BANTEL SAC" con código de recaudo 22327',
                              'Brinda tu "RUC o Dni"',
                              'Recibe el Voucher y listo',
                            ]),
                            _buildStepsSection([
                              'Ingresa a la App BCP',
                              'Dirígete a la sección "Pagar Servicios"',
                              'Indica en buscador: "BANDTEL SAC"',
                              'Digita tu DNI, C.E. ó RUC',
                              'Continuar'
                            ]),
                            _buildStepsSection([
                              'Ingresa a tu cuenta BCP',
                              'Selecciona "Pagar Servicios" e "Instituciones y Empresas"',
                              'Ingresa el nombre: "BANDTEL SAC"',
                              'Indica tu DNI, C.E. ó RUC',
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showBBVAModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Versión-Móvil_FONDO_BBVA.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: DefaultTabController(
                  length: 3,
                  child: Wrap(
                    children: [
                      // Icono de cierre
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.timesCircle,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      // Logo y título
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/logo/Versión-Móvil_BBVA-16.png',
                                height: 60,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'PAGA TU RECIBO POR BBVA',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      // TabBar
                      TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey[400],
                        indicatorColor: Colors.white,
                        tabs: const [
                          Tab(text: 'Agente BBVA'),
                          Tab(text: 'App BBVA'),
                          Tab(text: 'Banca por Internet'),
                        ],
                      ),
                      // Contenido de las pestañas
                      SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.5, // Máximo 50% de la pantalla
                        child: TabBarView(
                          children: [
                            _buildStepsSection([
                              'Acércate a un Agente BBVA más cercana',
                              'Indica el nombre del convenio "BANTEL SOLES" con código de recaudo 18150',
                              'Brinda tu "RUC o Dni"',
                              'Recibe el Voucher y listo',
                            ]),
                            _buildStepsSection([
                              'Ingresa a la App BBVA',
                              'Dirígete a la sección "Pagar Servicios"',
                              'Indica en buscador: "BANTEL SOLES"',
                              'Digita tu DNI, C.E. ó RUC',
                              'Continuar'
                            ]),
                            _buildStepsSection([
                              'Ingresa a tu cuenta BBVA',
                              'Selecciona "Pagar Servicios" e "Instituciones y Empresas"',
                              'Ingresa el nombre: "BANTEL SOLES"',
                              'Indica tu DNI, C.E. ó RUC',
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepsSection(List<String> steps) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps
              .asMap()
              .entries
              .map((entry) => _buildStep(
                  entry.key + 1, entry.value, Colors.white, Colors.black))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildStep(
      int stepNumber, String description, Color colorfondo, Color colortexto) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7), // Fondo blanco semitransparente
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white, width: 2.0), // Borde blanco
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorfondo,
            child: Text(
              stepNumber.toString(),
              style: TextStyle(color: colortexto),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
