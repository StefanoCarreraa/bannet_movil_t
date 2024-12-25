import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Color verdeLima = Color(0xFFA5CD39); // Verde lima
  final Color grisFondo = Color(0xFFF5F5F5); // Gris claro
  final Color grisOscuro = Color(0xFF333333); // Gris oscuro para detalles
  final Color blanco = Colors.white; // Blanco puro

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
            _construirElementoLista(Icons.settings, 'Configuración de la app'),
            _construirTituloSeccion('Cuenta'),
            _construirElementoLista(Icons.edit, 'Cambiar nombre de cuenta'),
            _construirElementoLista(
                Icons.lock_outline, 'Cambiar contraseña de cuenta'),
            _construirElementoLista(Icons.image, 'Cambiar imagen de cuenta'),
            _construirTituloSeccion('Uptodo'),
            _construirElementoLista(Icons.info_outline, 'Acerca de nosotros'),
            _construirElementoLista(
                Icons.help_outline, 'Preguntas frecuentes (FAQ)'),
            _construirElementoLista(
                Icons.feedback_outlined, 'Ayuda y comentarios'),
            _construirElementoLista(Icons.support_agent, 'Soporte'),
            _construirBotonCerrarSesion(),
          ],
        ),
      ),
    );
  }

  Widget _construirEncabezadoPerfil() {
    return Column(
      children: [
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/perfil.png'), // Imagen de perfil
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

  Widget _construirElementoLista(IconData icono, String titulo) {
    return ListTile(
      leading: Icon(icono, color: grisOscuro),
      title: Text(
        titulo,
        style: TextStyle(fontSize: 16, color: grisOscuro),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: grisOscuro),
      onTap: () {
        print('Seleccionado: $titulo');
      },
    );
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
