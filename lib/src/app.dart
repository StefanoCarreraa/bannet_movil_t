import 'package:bannet_movil_t/src/View/Login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    @override
  void initState() {
    super.initState();
    _solicitarPermisos();
  }

    // Función para solicitar permisos de almacenamiento
  Future<void> _solicitarPermisos() async {
    // Verificar la versión de Android
    if (await Permission.storage.isGranted) {
      print("Permiso de almacenamiento ya concedido");
    } else if (await Permission.storage.isDenied) {
      // Si el permiso no ha sido concedido, solicitarlo
      var status = await Permission.storage.request();

      if (status.isGranted) {
        print("Permiso de almacenamiento concedido");
      } else if (status.isDenied) {
        print("Permiso de almacenamiento denegado");
      }
    }

    // Verificar si es Android 11 o superior para el permiso MANAGE_EXTERNAL_STORAGE
    if (await Permission.manageExternalStorage.isDenied) {
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        print("Permiso para acceso completo al almacenamiento concedido");
      } else {
        print("Permiso para acceso completo al almacenamiento denegado");
        // Opcional: redirigir a la configuración
        openAppSettings();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      
      home: Loginscreen(),
    );
  }
}
