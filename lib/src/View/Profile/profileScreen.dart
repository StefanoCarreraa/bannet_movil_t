import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39); // Verde lima
  final Color grisFondo = Color(0xFFF5F5F5); // Gris claro
  final Color grisOscuro = Color(0xFF333333); // Gris oscuro para detalles
  final Color blanco = Colors.white;

  ProfileScreen({super.key}); // Blanco puro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      appBar: AppBar(
        backgroundColor: blanco,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(
            color: grisOscuro,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: grisOscuro),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _construirEncabezadoPerfil(),
            Divider(color: Colors.grey.shade300, thickness: 1),
            _construirTituloSeccion('Configuración'),
            _construirElementoLista(Icons.settings, 'Configuración de la app',
                () async {
              _mostrarInformacion(context);
            }),
            _construirTituloSeccion('Cuenta'),
            _construirElementoLista(
                Icons.email, 'Cambiar correo electrónico', () {}),
            _construirElementoLista(
                Icons.phone, 'Cambiar número de teléfono', () {}),
            _construirElementoLista(
                Icons.lock_outline, 'Cambiar contraseña de cuenta', () {}),
            _construirTituloSeccion('App'),
            _construirElementoLista(
                Icons.info_outline, 'Acerca de nosotros', () {}),
            _construirElementoLista(
                Icons.help_outline, 'Preguntas frecuentes (FAQ)', () {}),
            _construirElementoLista(
                Icons.feedback_outlined, 'Ayuda y comentarios', () {}),
            _construirElementoLista(Icons.support_agent, 'Soporte', () {}),
            _construirBotonCerrarSesion(),
          ],
        ),
      ),
    );
  }

  void _mostrarInformacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Cambiar color de app',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  icon: Icons.color_lens,
                  text: 'Tema Claro',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  appcolor: Colors.white,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  icon: Icons.color_lens_outlined,
                  text: 'Tema Oscuro',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  appcolor: Colors.white,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _construirEncabezadoPerfil() {
    return Column(
      children: [
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage:
              AssetImage('assets/images/perfil.png'), // Imagen de perfil
        ),
        SizedBox(height: 10),
        Text(
          'Stefano Carrera',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: grisOscuro,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _construirTituloSeccion(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          titulo,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: grisOscuro,
          ),
        ),
      ),
    );
  }

  Widget _construirElementoLista(
      IconData icono, String titulo, VoidCallback onTap) {
    return ListTile(
        leading: Icon(icono, color: grisOscuro),
        title: Text(
          titulo,
          style: TextStyle(fontSize: 16, color: grisOscuro),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: grisOscuro),
        onTap: onTap);
  }

  Widget _construirBotonCerrarSesion() {
    return ListTile(
      leading: Icon(Icons.logout, color: Colors.red),
      title: Text(
        'Cerrar sesión',
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
      onTap: () {
        print('Cerrando sesión...');
      },
    );
  }
}
class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? textColor;
  final Color? appcolor;

  const CustomButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    this.iconColor,
    this.textColor,
    this.appcolor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: appcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 25),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor ?? Colors.black),
          Text(
            text,
            style: TextStyle(color: textColor ?? Colors.black),
          ),
          Icon(Icons.keyboard_arrow_right, color: iconColor ?? Colors.black),
        ],
      ),
    );
  }
}
