import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Recibo/Recibo_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/comprobante_controller.dart';
import 'package:bannet_movil_t/src/View/Comprobante/ComprobanteScreen.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/TaskCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Listcomprobantesscreen extends StatefulWidget {
  const Listcomprobantesscreen({super.key});

  @override
  State<Listcomprobantesscreen> createState() => _ListcomprobantesscreenState();
}

class _ListcomprobantesscreenState extends State<Listcomprobantesscreen> {
  final LoginController _logincontroller = LoginController();

  int idPersona = 0;
  Future<void> _loadUserData() async {
    final userData = await _logincontroller.loadUserData();
    setState(() {
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
      final comprobanteController =
          Provider.of<ComprobanteController>(context, listen: false);
      comprobanteController.fetchComprobantes(idPersona);
    });
  }

  @override
  Widget build(BuildContext context) {
    final comprobanteController = Provider.of<ComprobanteController>(context);

    return Scaffold(
      backgroundColor: AppColors.blanco, // Fondo blanco
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_miportal.png',
          height: 55,
        ),
        toolbarHeight: 60,
        backgroundColor: AppColors.negro,
        centerTitle: true, // Garantiza que el título esté centrado
        iconTheme: IconThemeData(color: AppColors.verdeLima),
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
                  "Comprobantes",
                  style: TextStyle(
                      color: AppColors.verdeLima,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              comprobanteController.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : comprobanteController.comprobantes.isEmpty
                      ? Center(
                          child: Text(
                            "No hay recibos disponibles.",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap:
                              true, // Hace que ListView ocupe solo el espacio necesario
                          itemCount: comprobanteController.comprobantes.length,
                          itemBuilder: (context, index) {
                            final comprobante =
                                comprobanteController.comprobantes[index];
                            return TaskCardWidget(
                              titulo:
                                  'Nro. Recibo: ${comprobante.nroComprobante}',
                              subtitulo: 'fecha: ${comprobante.fecha}',
                              periodo: 'importe: ${comprobante.total}',
                              // precio: 'Monto: ${comprobante.importe}',
                              // estado: 'Estado: ${comprobante.nombreEstadoRecibo}',
                              color: AppColors.verdeLima,
                              isCompleted: false,
                              expandedContent: _buildMiRecibo(),
                            );
                          },
                        ),
              // TaskCardWidget(
              //   titulo: 'Nro. Comprobante : 000000000598866',
              //   subtitulo: 'Tipo Comprobante: BOLETA DE VENTA ELECTRONICA',
              //   // periodo: 'Periodo: 2025-ENERO',
              //   fecha: 'Fecha: 21/09/2024',
              //   precio: 'Monto : S/. 35.00',
              //   color: AppColors.verdeLima,
              //   isCompleted: false,
              //   expandedContent: _buildMiRecibo(),
              // ),
              SizedBox(height: 30),
              Divider(
                color: AppColors.verdeLima,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiRecibo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.receipt_long_outlined, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                '¿Qué quieres hacer hoy?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoton('Descargar Comprobante', AppColors.blanco,
                  AppColors.negro, true),
              // SizedBox(width: 20),
              // _buildBoton('Pagar', verdeLima, Colors.white, true),
            ],
          ),
        ],
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
                  ? BorderSide(color: Colors.black12, width: 2)
                  : BorderSide.none,
            ),
          ),
          onPressed: () {
            if (texto == 'Descargar Comprobante') {
              // Navegar a la pantalla del recibo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Comprobantescreen()),
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
}
