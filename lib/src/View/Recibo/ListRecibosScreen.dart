import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Recibo/Recibo_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/reciboimpresion_controller.dart';
import 'package:bannet_movil_t/src/Models/reciboImpresion_model%20.dart';
import 'package:bannet_movil_t/src/Services/pdfRecibo_service.dart';
import 'package:bannet_movil_t/src/View/Recibo/ReciboScreen.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/TaskCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Listrecibosscreen extends StatefulWidget {
  const Listrecibosscreen({super.key});

  @override
  State<Listrecibosscreen> createState() => _ListrecibosscreenState();
}

class _ListrecibosscreenState extends State<Listrecibosscreen> {
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
      final reciboController =
          Provider.of<ReciboController>(context, listen: false);
      reciboController.fetchRecibosPendientes(idPersona);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reciboController = Provider.of<ReciboController>(context);

    return Scaffold(
      backgroundColor: AppColors.negro,
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
                print("refresh");
                final reciboController =
                    Provider.of<ReciboController>(context, listen: false);
                await reciboController.fetchRecibosPendientes(idPersona);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Mis recibos",
                        style: TextStyle(
                          color: AppColors.verdeLima,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    reciboController.recibos.isEmpty
                        ? Center(
                            child: Text(
                              "No hay recibos disponibles.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: reciboController.recibos.length,
                            itemBuilder: (context, index) {
                              final recibo = reciboController.recibos[index];
                              return TaskCardWidget(
                                titulo: 'Nro. Recibo: ${recibo.numeroRecibo}',
                                subtitulo: 'Plan: ${recibo.nombreServicio}',
                                periodo: 'Periodo: ${recibo.periodo}',
                                precio: 'Monto: ${recibo.importe}',
                                estado: 'Estado: ${recibo.nombreEstadoRecibo}',
                                color: AppColors.verdeLima,
                                isCompleted: false,
                                expandedContent:
                                    _buildMiRecibo(recibo.idDocCobrar),
                              );
                            },
                          ),
                    SizedBox(height: 30),
                    Divider(
                      color: AppColors.verdeLima,
                      thickness: 1,
                    ),
                    SizedBox(height: 20),
                    _buildMontoPagarCard(
                      titulo: "Monto a pagar",
                      monto:
                          "S/. ${reciboController.totalMontoPagar.toStringAsFixed(2)}",
                    ),
                    reciboController.totalMontoPagar == 0.0
                        ? _buildGeneral()
                        : _buildGeneral1(),
                  ],
                ),
              ),
            ),
            if (reciboController.isLoading)
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

  Widget _buildMiRecibo(int idDocCobrar) {
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
                'Descargar Recibo',
                AppColors.blanco,
                AppColors.negro,
                true,
                idDocCobrar,
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
    int idDocCobrar,
  ) {
    ReciboImpresionController reciboImpresionController =
        ReciboImpresionController();
    PdfreciboService pdfreciboService = PdfreciboService();
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

            await reciboImpresionController.fetchRecibosPendientes(idDocCobrar);
            List<ReciboimpresionModel> lista =
                reciboImpresionController.recibos;

            if (lista.isEmpty) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("No hay recibos pendientes")),
                );
              }
              setState(() => isLoading = false);
              return;
            }

            final List<String?> filePath =
                await pdfreciboService.DescargarPdfRrecibo(lista);

            if (filePath.isNotEmpty) {
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReciboScreen(filePath.whereType<String>().toList()),
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

  Widget _buildMontoPagarCard({required String titulo, required String monto}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading:
            Icon(Icons.payment_outlined, color: AppColors.verdeLima, size: 36),
        title: Text(
          titulo,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.negro,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              monto,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.verdeLima,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneral() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Centra el título
                        Center(
                          child: Text(
                            "¡Felicidades, Bantelino!",
                            style: TextStyle(
                                color: AppColors.verdeLima,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 14),

                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No tienes deudas.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Pagaste tu último recibo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneral1() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Centra el título
                        Center(
                          child: Text(
                            "¡Deudas Pendientes!",
                            style: TextStyle(
                                color: AppColors.verdeLima,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 14),

                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Regulariza tus pagos para seguir",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "disfrutando de Bantel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
