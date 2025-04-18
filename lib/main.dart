import 'package:bannet_movil_t/src/Controllers/Contrato/Contrato_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Recibo/Recibo_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/TipoServicio/TipoServicio_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/baja_suspension_controller.dart';
import 'package:bannet_movil_t/src/Controllers/comprobante_controller.dart';
import 'package:bannet_movil_t/src/Controllers/libroreclamacion_controller.dart';
import 'package:bannet_movil_t/src/Controllers/postventa_controller.dart';
import 'package:bannet_movil_t/src/Controllers/user_controller.dart';
import 'package:bannet_movil_t/src/Services/auth_service.dart';
import 'package:bannet_movil_t/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLoggedIn = await AuthService().checkLoginStatus();

  await solicitarPermisosUbicacion();
// Configurar el estilo del sistema UI.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // Color de fondo de la barra.
    systemNavigationBarIconBrightness:
        Brightness.light, // Color de los íconos (blanco en este caso).
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => ReciboController()),
        ChangeNotifierProvider(create: (_) => ContratoController()),
        ChangeNotifierProvider(create: (_) => TipoServicioController()),
        ChangeNotifierProvider(create: (_) => BajaSuspensionController()),
        ChangeNotifierProvider(create: (_) => PostventaController()),
        ChangeNotifierProvider(create: (_) => LibroReclamacionController()),
        ChangeNotifierProvider(create: (_) => ComprobanteController()),
        ChangeNotifierProvider(create: (_) => UserController()),
      ],
      child: MyApp(
        isLoggedIn: isLoggedIn,
      ),
    ));
  });
}

Future<void> solicitarPermisosUbicacion() async {}
