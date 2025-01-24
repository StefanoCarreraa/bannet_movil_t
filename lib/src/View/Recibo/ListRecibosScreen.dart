import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Recibo/Recibo_Controller.dart';
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
      final reciboController =
          Provider.of<ReciboController>(context, listen: false);
      reciboController.fetchRecibosPendientes(idPersona);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reciboController = Provider.of<ReciboController>(context);

    return Scaffold(
        backgroundColor: AppColors.negro, // Fondo blanco
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
                SizedBox(
                  height: 20,
                ),
                // Verificamos si el controller está cargando o si no hay recibos
                reciboController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : reciboController.recibos.isEmpty
                        ? Center(
                            child: Text(
                              "No hay recibos disponibles.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap:
                                true, // Hace que ListView ocupe solo el espacio necesario
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
                  titulo: "Monto facturado",
                  monto: "S/. 155.00",
                ),
                _buildMontoPagarCard(
                  titulo: "Monto a pagar",
                  monto: "S/. 0.00",
                ),
                _buildGeneral(),
              ],
            ),
          ),
        ));
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
            mainAxisAlignment: MainAxisAlignment.center, // Centra la columna
            crossAxisAlignment: CrossAxisAlignment
                .center, // Centra los elementos dentro de la columna
            mainAxisSize: MainAxisSize
                .min, // Hace que la columna solo ocupe el espacio necesario
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centra el contenido de la fila
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Centra los elementos dentro de la columna
                      children: [
                        // Centra el título
                        Center(
                          child: Text(
                            "¡Felicidades, Bantelino!",
                            style: TextStyle(
                                color: AppColors.verdeLima,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign
                                .center, // Asegura que el texto se mantenga centrado
                          ),
                        ),
                        SizedBox(height: 14),
                        // Centra el contenido
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centra el texto dentro de la columna
                            children: [
                              Text(
                                "No tienes deudas.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign
                                    .center, // Asegura que el texto se mantenga centrado
                              ),
                              Text(
                                "Pagaste tu último recibo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign
                                    .center, // Asegura que el texto se mantenga centrado
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
