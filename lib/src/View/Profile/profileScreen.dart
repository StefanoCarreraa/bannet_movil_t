import 'dart:ui';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final LoginController _logincontroller = LoginController();

  final Color verdeLima = Color(0xFFA5CD39); // Verde lima
  final Color grisFondo = Color(0xFFF5F5F5); // Gris claro
  final Color grisOscuro = Color(0xFF333333); // Gris oscuro para detalles
  final Color blanco = Colors.white; // Blanco puro
  final Color negro = Colors.black; // Blanco puro

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: negro,
      appBar: AppBar(
        backgroundColor: negro,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(
            color: blanco,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: verdeLima),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _construirEncabezadoPerfil(),
            Divider(color: verdeLima, thickness: 1),
            _construirTituloSeccion('Configuración'),
            _construirElementoLista(Icons.settings, 'Configuración de la app',
                () async {
              _mostrarConfiCustomActionSheet(context);
            }),
            _construirTituloSeccion('Cuenta'),
            _construirElementoLista(Icons.email, 'Cambiar correo electrónico',
                () {
              _mostrarCorreoCustomActionSheet(context);
            }),
            _construirElementoLista(Icons.phone, 'Cambiar número de teléfono',
                () {
              _mostrarTelefonoCustomActionSheet(context);
              // mostrarNotificacion(
              //   context: context,
              //   titulo: 'Titulo Notificacion',
              //   mensaje: "Prueba de Notificacion",
              // );
            }),

            _construirElementoLista(
                Icons.lock_outline, 'Cambiar contraseña de cuenta', () {
              _mostrarContrasCustomActionSheet(context);
            }),
            _construirTituloSeccion('App'),
            // _construirElementoLista(
            //     Icons.info_outline, 'Acerca de nosotros', () {}),
            // _construirElementoLista(
            //     Icons.help_outline, 'Preguntas frecuentes (FAQ)', () {}),
            // _construirElementoLista(
            //     Icons.feedback_outlined, 'Ayuda y comentarios', () {}),
            // _construirElementoLista(Icons.support_agent, 'Soporte', () {}),
            _construirBotonCerrarSesion(() {
              _mostrarConfirmacionCerrarSesion(context);
            }),
          ],
        ),
      ),
    );
  }

  void _mostrarConfiCustomActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: grisOscuro,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Cambiar color de app',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      icon: Icons.color_lens,
                      text: 'Tema Claro',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      appcolor: verdeLima,
                      textColor: blanco,
                      iconColor: blanco,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CustomButton(
                      icon: Icons.color_lens,
                      text: 'Tema Claro',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      appcolor: verdeLima,
                      textColor: blanco,
                      iconColor: blanco,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blanco,
                              padding: EdgeInsets.symmetric(vertical: 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarCorreoCustomActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: grisOscuro,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SingleChildScrollView(
            // Hacemos el contenido desplazable
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 50,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'Cambiar correo electrónico',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[800],
                          hintText: 'Ingrese su nuevo correo',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blanco,
                                padding: EdgeInsets.symmetric(vertical: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancelar',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: verdeLima,
                                padding: EdgeInsets.symmetric(vertical: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                              ),
                              onPressed: () {
                                print('Correo actualizado');
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Actualizar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _mostrarTelefonoCustomActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: grisOscuro,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Cambiar número de Teléfono',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        hintText: 'Ingrese su nuevo numero de Teléfono',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blanco,
                              padding: EdgeInsets.symmetric(vertical: 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeLima,
                            padding: EdgeInsets.symmetric(vertical: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                          onPressed: () {
                            print('Correo actualizado');
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Actualizar',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarContrasCustomActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: grisOscuro,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Cambiar Contraseña',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        hintText: 'Ingrese su nueva Contraseña',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        hintText: 'Confirmar su nueva Contraseña',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blanco,
                              padding: EdgeInsets.symmetric(vertical: 25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeLima,
                            padding: EdgeInsets.symmetric(vertical: 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                          ),
                          onPressed: () {
                            print('Correo actualizado');
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Actualizar',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarConfirmacionCerrarSesion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.grisOscuro,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicador de deslizar
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.grisFondo,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              // Contenido del diálogo
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Mensaje de éxito
                    Text(
                      'Confirmación!!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "¿Estás seguro de que deseas cerrar sesión?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 40),
                    // Botón Cancelar
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blanco,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blanco,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.red, width: 2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _logincontroller.logout(context);
                            },
                            child: Text(
                              'Cerrar Sesión',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
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
            color: blanco,
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
            color: verdeLima,
          ),
        ),
      ),
    );
  }

  Widget _construirElementoLista(
      IconData icono, String titulo, VoidCallback onTap) {
    return ListTile(
        leading: Icon(icono, color: verdeLima),
        title: Text(
          titulo,
          style: TextStyle(fontSize: 16, color: blanco),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: verdeLima),
        onTap: onTap);
  }

  Widget _construirBotonCerrarSesion(VoidCallback onTap) {
    return ListTile(
        leading: Icon(Icons.logout, color: Colors.red),
        title: Text(
          'Cerrar sesión',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
        onTap: onTap);
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
    final Color verdeLima = Color(0xFFA5CD39); // Verde lima

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: appcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor ?? verdeLima),
          Text(
            text,
            style: TextStyle(color: textColor ?? Colors.white),
          ),
          Icon(Icons.keyboard_arrow_right, color: iconColor ?? verdeLima),
        ],
      ),
    );
  }
}
