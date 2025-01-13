import 'package:bannet_movil_t/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await solicitarPermisosUbicacion();
// Configurar el estilo del sistema UI.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // Color de fondo de la barra.
    systemNavigationBarIconBrightness: Brightness.light, // Color de los íconos (blanco en este caso).
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}


Future<void> solicitarPermisosUbicacion() async {

}
