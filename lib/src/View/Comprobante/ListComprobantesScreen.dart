import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/comprobante_controller.dart';
import 'package:bannet_movil_t/src/Controllers/comprobanteimpresion_controller.dart';
import 'package:bannet_movil_t/src/Controllers/pdfDescargas_controller.dart';
import 'package:bannet_movil_t/src/Models/comprobanteImpresion_model.dart';
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
  bool isLoading = false;

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
      backgroundColor: AppColors.blanco,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_miportal.png',
          height: 55,
        ),
        toolbarHeight: 60,
        backgroundColor: AppColors.negro,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.verdeLima),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Bannet_Fond.jpg'),
            fit: BoxFit.cover,
          ),
          color: Color(0xFF000000),
        ),
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                final comprobanteController =
                    Provider.of<ComprobanteController>(context, listen: false);
                comprobanteController.fetchComprobantes(idPersona);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Comprobantes",
                        style: TextStyle(
                            color: AppColors.verdeLima,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 20),
                    comprobanteController.comprobantes.isEmpty
                        ? Center(
                            child: Text(
                              "No hay Comprobantes disponibles.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                comprobanteController.comprobantes.length,
                            itemBuilder: (context, index) {
                              final comprobante =
                                  comprobanteController.comprobantes[index];
                              return TaskCardWidget(
                                titulo:
                                    'Nro. Comprobante: ${comprobante.nroComprobante}',
                                subtitulo: 'Fecha: ${comprobante.fecha}',
                                periodo: 'Importe: ${comprobante.total}',
                                color: AppColors.verdeLima,
                                isCompleted: false,
                                expandedContent:
                                    _buildMiRecibo(comprobante.idDocVenta),
                              );
                            },
                          ),
                    SizedBox(height: 30),
                    Divider(
                      color: AppColors.verdeLima,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            if (comprobanteController.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiRecibo(int idDocVenta) {
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
              _buildBoton(
                'Descargar Comprobante',
                AppColors.blanco,
                AppColors.negro,
                true,
                idDocVenta,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoton(
    String texto,
    Color colorFondo,
    Color colorTexto,
    bool conBorde,
    int idDocVenta,
  ) {
    ComprobanteImpresionController comprobanteImpresionController =
        ComprobanteImpresionController();
    PdfdescargasController pdfdescargasController = PdfdescargasController();

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
          onPressed: () async {
            if (isLoading) return;

            setState(() => isLoading = true);

            await comprobanteImpresionController
                .fetchComprobantesPendientesImpresion(idDocVenta);

            List<ComprobanteImpresionModel> lista =
                comprobanteImpresionController.comprobantes;

            if (lista.isEmpty) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("No hay comprobantes pendientes")),
                );
                return;
              }
            }

            final List<String?> filePath =
                await pdfdescargasController.descargarPDF(lista, idPersona);

            if (filePath.isNotEmpty) {
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Comprobantescreen(
                        filePath.whereType<String>().toList()),
                  ),
                );
              }
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error al descargar el PDF")),
                );
              }
            }
            setState(() => isLoading = false);
          },
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  texto,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
        );
      },
    );
  }
}
