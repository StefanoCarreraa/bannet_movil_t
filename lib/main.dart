import 'package:bannet_movil_t/src/Controllers/Contrato/Contrato_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Recibo/Recibo_Controller.dart';
import 'package:bannet_movil_t/src/app.dart';
import 'package:bannet_movil_t/src/services/auth_service.dart';
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
      ],
      child: MyApp(
        isLoggedIn: isLoggedIn,
      ),
    ));
  });
}

Future<void> solicitarPermisosUbicacion() async {}
