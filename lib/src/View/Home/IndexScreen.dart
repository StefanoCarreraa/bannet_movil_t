import 'dart:ui';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Recibo/Recibo_Controller.dart';
import 'package:bannet_movil_t/src/View/Comprobante/ListComprobantesScreen.dart';
import 'package:bannet_movil_t/src/View/Profile/profileScreen.dart';
import 'package:bannet_movil_t/src/View/Recibo/ListRecibosScreen.dart';
import 'package:bannet_movil_t/src/View/ZonaGamer/ZonaGamerScreen.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/DrawerSectionCustom.dart';
import 'package:bannet_movil_t/src/widget/TaskCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Indexscreen extends StatefulWidget {
  const Indexscreen({
    super.key,
  });

  @override
  State<Indexscreen> createState() => _IndexscreenState();
}

class _IndexscreenState extends State<Indexscreen> {
  final LoginController _logincontroller = LoginController();
  bool _isExpanded = true;
  int _selectedIndex = 0;
  final GlobalKey _key1 = GlobalKey();

  double _width = 0; // Variable para almacenar el largo del widget

  String nombreOrganizacion = 'Cargando...';
  int idPersona = 0;

  Future<void> _loadUserData() async {
    final userData = await _logincontroller.loadUserData();
    setState(() {
      nombreOrganizacion = userData['nombreOrganizacion'];
      idPersona = userData['idPersona'];
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUserData();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reciboController =
          Provider.of<ReciboController>(context, listen: false);
      reciboController.fetchRecibosPendientes(idPersona);
    });
  }

  void _mostrarConfirmacionCerrarSesion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.grisOscuro,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicador de deslizar
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.grisFondo,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              // Contenido del diálogo
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Mensaje de éxito
                    Text(
                      'Confirmación!!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "¿Estás seguro de que deseas cerrar sesión?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 40),
                    // Botón Cancelar
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blanco,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blanco,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _logincontroller.logout(context);
                            },
                            child: Text(
                              'Cerrar Sesión',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateBasedOnIndex(BuildContext context, int index) {
    // Mapa de índices a pantallas
    final Map<int, Widget> screens = {
      1: Listrecibosscreen(),
      2: Listcomprobantesscreen(),
      3: ZonaGamerScreen(),
    };

    if (screens.containsKey(index)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screens[index]!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final reciboController = Provider.of<ReciboController>(context);

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
      key: _key1,
      backgroundColor: AppColors.negro,
      appBar: AppBar(
        backgroundColor: AppColors.negro,
        iconTheme: IconThemeData(color: AppColors.verdeLima),
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
                icon: Icon(Icons.account_circle, color: AppColors.verdeLima),
                onPressed: () {
                  final RenderBox appBarBox =
                      context.findRenderObject() as RenderBox;
                  final Offset position = appBarBox
                      .localToGlobal(Offset.zero); // Posición global del AppBar
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      position.dx + appBarBox.size.width - 60,
                      position.dy + appBarBox.size.height + 5,
                      0,
                      0,
                    ),
                    items: [
                      PopupMenuItem(
                        value: 'Perfil',
                        child: Row(
                          children: [
                            Icon(Icons.person, color: AppColors.verdeLima),
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
                SizedBox(height: 5),
                //
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          "Planes",
                          style: TextStyle(
                              color: AppColors.verdeLima,
                              fontSize: 26,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      reciboController.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : reciboController.recibos.isEmpty
                              ? Center(
                                  child: Text(
                                    "No hay recibos disponibles.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )
                              : Column(
                                  children:
                                      reciboController.recibos.map((recibo) {
                                    return TaskCardWidget(
                                      titulo:
                                          'Nro. Recibo: ${recibo.numeroRecibo}',
                                      subtitulo:
                                          'Plan: ${recibo.nombreServicio}',
                                      periodo: 'Periodo: ${recibo.periodo}',
                                      precio: 'Monto: ${recibo.importe}',
                                      estado:
                                          'Estado: ${recibo.nombreEstadoRecibo}',
                                      color: AppColors.verdeLima,
                                      isCompleted: false,
                                    );
                                  }).toList(),
                                )

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
                color: _isExpanded
                    ? AppColors.grisOscuro
                    : Colors.white, // Fondo ajustado
                borderRadius: BorderRadius.circular(_isExpanded ? 12 : 8),
                border: Border.all(
                  color: AppColors.verdeLima, // Color del borde verde
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
                                        color: AppColors.verdeLima,
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
                                    color: AppColors.verdeLima,
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
                        color: AppColors.verdeLima,
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
          canvasColor: AppColors.negro, // Fondo negro de la barra de navegación
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white, // Elementos seleccionados en blanco
          unselectedItemColor:
              Colors.grey, // Elementos no seleccionados en gris
          showUnselectedLabels: true,
          onTap: (index) {
            navigateBasedOnIndex(context, index);
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
    String ParteNombre1 = "";
    String ParteNombre2 = "";
    void splitName(String fullName) {
      // Dividimos el nombre en palabras
      List<String> words = fullName.split(' ');

      if (words.length > 2) {
        // Si hay más de dos palabras, unimos las dos primeras y el resto
        String firstPart = words.take(2).join(' ');
        String secondPart = words.skip(2).join(' ');
        ParteNombre1 = firstPart;
        ParteNombre2 = secondPart;
      }
    }

    splitName(nombreOrganizacion);

    double adjustedHeight = _width < 615
        ? 160
        : 110; // Si el ancho es menor que 615, la altura será 200

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
                    'Bienvenido,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
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
                                ParteNombre1, // Mostrar todo el nombre si el ancho es suficiente
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 22,
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
                                ParteNombre2, // Mostrar todo el nombre si el ancho es suficiente
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 22,
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
                          nombreOrganizacion, // Mostrar todo el nombre si el ancho es suficiente
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
                              FontAwesomeIcons.circleXmark,
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
                              FontAwesomeIcons.circleXmark,
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
                              FontAwesomeIcons.circleXmark,
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
