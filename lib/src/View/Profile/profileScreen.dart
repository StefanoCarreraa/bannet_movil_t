// ignore: unnecessary_import
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/user_controller.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/AlertshowModalBottomSheet.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nombreOrganizacion = 'Cargando...';
  int idUsuarioBannet = 0;

  Future<void> _loadUserData() async {
    final userData = await _logincontroller.loadUserData();
    setState(() {
      nombreOrganizacion = userData['nombreOrganizacion'];
      idUsuarioBannet = userData['idUsuarioBannet'];
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUserData();
  }

  final LoginController _logincontroller = LoginController();

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      backgroundColor: AppColors.negro,
      appBar: AppBar(
        backgroundColor: AppColors.negro,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(
            color: AppColors.blanco,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.verdeLima),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _construirEncabezadoPerfil(),

            Divider(
              color: AppColors.verdeLima,
              thickness: 1,
            ),
            // _construirTituloSeccion('Configuración'),
            // _construirElementoLista(Icons.settings, 'Configuración de la app',
            //     () async {
            //   _mostrarConfiCustomActionSheet(context);
            // }),
            _construirTituloSeccion('Cuenta'),
            _construirElementoLista(Icons.email, 'Cambiar correo electrónico',
                () {
              _mostrarCorreoCustomActionSheet(
                context,
                userController,
                idUsuarioBannet,
              );
            }),
            _construirElementoLista(Icons.phone, 'Cambiar número de teléfono',
                () {
              _mostrarTelefonoCustomActionSheet(
                context,
                userController,
                idUsuarioBannet,
              );
            }),

            _construirElementoLista(
                Icons.lock_outline, 'Cambiar contraseña de cuenta', () {
              _mostrarContrasCustomActionSheet(
                  context, userController, idUsuarioBannet);
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

  // void _mostrarConfiCustomActionSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     builder: (BuildContext context) {
  //       return Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.grisOscuro,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(16),
  //             topRight: Radius.circular(16),
  //           ),
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               height: 5,
  //               width: 50,
  //               margin: EdgeInsets.symmetric(vertical: 10),
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[700],
  //                 borderRadius: BorderRadius.circular(2.5),
  //               ),
  //             ),
  //             Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  //               child: Column(
  //                 children: [
  //                   Text(
  //                     'Cambiar color de app',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   SizedBox(height: 20),
  //                   CustomButton(
  //                     icon: Icons.color_lens,
  //                     text: 'Tema Claro',
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     appcolor: AppColors.verdeLima,
  //                     textColor: AppColors.blanco,
  //                     iconColor: AppColors.blanco,
  //                   ),
  //                   SizedBox(
  //                     height: 16,
  //                   ),
  //                   CustomButton(
  //                     icon: Icons.color_lens,
  //                     text: 'Tema Claro',
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     appcolor: AppColors.verdeLima,
  //                     textColor: AppColors.blanco,
  //                     iconColor: AppColors.blanco,
  //                   ),
  //                   SizedBox(height: 20),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: AppColors.blanco,
  //                             padding: EdgeInsets.symmetric(vertical: 25),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(12),
  //                               side: BorderSide(color: Colors.white, width: 2),
  //                             ),
  //                           ),
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: Text(
  //                             'Cancelar',
  //                             style: TextStyle(color: Colors.black),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _mostrarCorreoCustomActionSheet(BuildContext context,
      UserController userController, int idUsuarioBannet) {
    TextEditingController correoController = TextEditingController();
    bool correoValido = false;
    bool campoVacio = true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grisOscuro,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
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
                          controller: correoController,
                          onChanged: (value) {
                            final emailRegex =
                                RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');
                            setModalState(() {
                              campoVacio = value.trim().isEmpty;
                              correoValido = emailRegex.hasMatch(value.trim());
                            });
                          },
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
                          keyboardType: TextInputType.emailAddress,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: LinearProgressIndicator(
                            value: campoVacio ? 0.0 : 1.0,
                            minHeight: 6,
                            backgroundColor: Colors.grey[700],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              campoVacio
                                  ? Colors.grey
                                  : correoValido
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blanco,
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: Colors.white, width: 2),
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
                                  backgroundColor: AppColors.verdeLima,
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                                onPressed: userController.isLoading
                                    ? null
                                    : () async {
                                        String nuevoCorreo =
                                            correoController.text.trim();

                                        if (!correoValido) {
                                          mostrarNotificacion(
                                            context: context,
                                            titulo: 'Error',
                                            mensaje:
                                                'Ingrese un correo válido.',
                                          );
                                          return;
                                        }

                                        bool resultado =
                                            await userController.cambiarEmail(
                                                idUsuarioBannet, nuevoCorreo);

                                        if (resultado) {
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                            mostrarNotificacion(
                                              context: context,
                                              titulo: 'Correo actualizado',
                                              mensaje:
                                                  'Correo electrónico actualizado con éxito',
                                            );
                                          }
                                        } else {
                                          if (context.mounted) {
                                            mostrarNotificacion(
                                              context: context,
                                              titulo: 'Error',
                                              mensaje:
                                                  'Error al actualizar el correo electrónico',
                                            );
                                          }
                                        }
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
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _mostrarTelefonoCustomActionSheet(BuildContext context,
      UserController userController, int idUsuarioBannet) {
    TextEditingController telefonoController = TextEditingController();
    double progresoTelefono = 0.0;
    bool campoVacio = true;
    bool longitudValida = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
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
                            controller: telefonoController,
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              setModalState(() {
                                campoVacio = value.trim().isEmpty;
                                longitudValida = value.length == 9;
                                progresoTelefono =
                                    value.length.clamp(0, 9) / 9.0;
                              });
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: Colors.grey[800],
                              hintText: 'Ingrese su nuevo número de Teléfono',
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
                          LinearProgressIndicator(
                            value: campoVacio ? 0.0 : progresoTelefono,
                            minHeight: 6,
                            backgroundColor: Colors.grey[700],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              campoVacio
                                  ? Colors.grey
                                  : longitudValida
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blanco,
                                    padding: EdgeInsets.symmetric(vertical: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
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
                                    backgroundColor: AppColors.verdeLima,
                                    padding: EdgeInsets.symmetric(vertical: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  onPressed: userController.isLoading
                                      ? null
                                      : () async {
                                          String nuevotelefono =
                                              telefonoController.text.trim();

                                          if (nuevotelefono.length != 9) {
                                            mostrarNotificacion(
                                              context: context,
                                              titulo: 'Error',
                                              mensaje:
                                                  'El número debe tener 9 dígitos',
                                            );
                                            return;
                                          }

                                          bool resultado =
                                              await userController.cambiarEmail(
                                                  idUsuarioBannet,
                                                  nuevotelefono);

                                          if (resultado) {
                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                              mostrarNotificacion(
                                                context: context,
                                                titulo: 'Teléfono actualizado',
                                                mensaje:
                                                    'Teléfono actualizado con éxito',
                                              );
                                            }
                                          } else {
                                            if (context.mounted) {
                                              mostrarNotificacion(
                                                context: context,
                                                titulo: 'Error',
                                                mensaje:
                                                    'Error al actualizar el Teléfono',
                                              );
                                            }
                                          }
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
      },
    );
  }

  Widget _buildRequisito(String texto, bool cumplido) {
    return Row(
      children: [
        Icon(
          cumplido ? Icons.check_circle : Icons.cancel,
          color: cumplido ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          texto,
          style: TextStyle(
            color: cumplido ? Colors.green : Colors.red,
            decoration:
                cumplido ? TextDecoration.none : TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }

  // Sección de cambiar contraseña
  bool contrasenasCoinciden = false;
  bool mostrarNueva = false;
  bool mostrarConfirmar = false;
  // Variables para mostrar requisitos de contraseña
  bool mostrarObservaciones = false;
  double progresoContrasena = 0.0;
  bool tieneMinuscula = false;
  bool tieneMayuscula = false;
  bool tieneNumero = false;
  bool tieneLongitud = false;

  void _mostrarContrasCustomActionSheet(BuildContext context,
      UserController userController, int idUsuarioBannet) {
    TextEditingController nuevaClaveController = TextEditingController();
    TextEditingController confirmarClaveController = TextEditingController();

    contrasenasCoinciden = false;
    mostrarNueva = false;
    mostrarConfirmar = false;
    mostrarObservaciones = false;
    progresoContrasena = 0.0;
    tieneMinuscula = false;
    tieneMayuscula = false;
    tieneNumero = false;
    tieneLongitud = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void calcularProgreso(String contrasena) {
              double progreso = 0.0;

              tieneMinuscula = RegExp(r'[a-z]').hasMatch(contrasena);
              tieneMayuscula = RegExp(r'[A-Z]').hasMatch(contrasena);
              tieneNumero = RegExp(r'\d').hasMatch(contrasena);
              tieneLongitud = contrasena.length >= 6;

              if (tieneMinuscula) progreso += 0.25;
              if (tieneMayuscula) progreso += 0.25;
              if (tieneNumero) progreso += 0.25;
              if (tieneLongitud) progreso += 0.25;

              setState(() {
                progresoContrasena = progreso;
              });
            }

            void verificarCoincidenciaContrasenas() {
              setState(() {
                contrasenasCoinciden = nuevaClaveController.text ==
                        confirmarClaveController.text &&
                    confirmarClaveController.text.isNotEmpty;
              });
            }

            return Container(
              decoration: BoxDecoration(
                color: AppColors.grisOscuro,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
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
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text(
                              'Mostrar observaciones de contraseña',
                              style: TextStyle(color: Colors.white),
                            ),
                            value: mostrarObservaciones,
                            onChanged: (value) {
                              setState(() {
                                mostrarObservaciones = value;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: nuevaClaveController,
                            obscureText: !mostrarNueva,
                            onChanged: (value) {
                              calcularProgreso(value);
                              verificarCoincidenciaContrasenas();
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[800],
                              hintText: 'Ingrese su nueva Contraseña',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  mostrarNueva
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    mostrarNueva = !mostrarNueva;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          if (mostrarObservaciones)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRequisito("Al menos una letra minúscula",
                                    tieneMinuscula),
                                _buildRequisito("Al menos una letra mayúscula",
                                    tieneMayuscula),
                                _buildRequisito(
                                    "Al menos un número", tieneNumero),
                                _buildRequisito(
                                    "Mínimo 6 caracteres", tieneLongitud),
                              ],
                            ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: progresoContrasena,
                            minHeight: 6,
                            backgroundColor: Colors.grey[700],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progresoContrasena < 1.0
                                  ? Colors.orange
                                  : Colors.green,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: confirmarClaveController,
                            obscureText: !mostrarConfirmar,
                            onChanged: (value) {
                              setState(() {
                                contrasenasCoinciden =
                                    value == nuevaClaveController.text &&
                                        value.isNotEmpty;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[800],
                              hintText: 'Confirmar su nueva Contraseña',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      mostrarConfirmar
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        mostrarConfirmar = !mostrarConfirmar;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          if (confirmarClaveController.text.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRequisito("Las Contraseñas coinciden",
                                    contrasenasCoinciden),
                              ],
                            ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blanco,
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
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
                                    backgroundColor: AppColors.verdeLima,
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  onPressed: userController.isLoading
                                      ? null
                                      : () async {
                                          String nuevaClave =
                                              nuevaClaveController.text.trim();
                                          String confirmarClave =
                                              confirmarClaveController.text
                                                  .trim();

                                          if (!contrasenasCoinciden ||
                                              !tieneMinuscula ||
                                              !tieneMayuscula ||
                                              !tieneNumero ||
                                              !tieneLongitud ||
                                              progresoContrasena < 1.0) {
                                            mostrarNotificacion(
                                              context: context,
                                              titulo: 'Error',
                                              mensaje:
                                                  'La contraseña no cumple con los requisitos',
                                            );
                                            return;
                                          }

                                          if (nuevaClave.isEmpty ||
                                              confirmarClave.isEmpty) {
                                            mostrarNotificacion(
                                              context: context,
                                              titulo: 'Error',
                                              mensaje:
                                                  'Los campos no pueden estar vacíos',
                                            );

                                            return;
                                          }

                                          if (nuevaClave != confirmarClave) {
                                            mostrarNotificacion(
                                              context: context,
                                              titulo: 'Error',
                                              mensaje:
                                                  'Las contraseñas no coinciden',
                                            );

                                            return;
                                          }

                                          setState(() {});

                                          bool resultado =
                                              await userController.cambiarClave(
                                                  idUsuarioBannet, nuevaClave);

                                          if (resultado) {
                                            if (context.mounted) {
                                              Navigator.of(context).pop();
                                              mostrarNotificacion(
                                                context: context,
                                                titulo:
                                                    'Contraseña actualizada',
                                                mensaje:
                                                    'Contraseña actualizada con éxito',
                                              );
                                            }
                                          } else {
                                            if (context.mounted) {
                                              mostrarNotificacion(
                                                context: context,
                                                titulo: 'Error',
                                                mensaje:
                                                    'Error al actualizar la contraseña',
                                              );
                                            }
                                          }
                                        },
                                  child: userController.isLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text(
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
          backgroundImage: AssetImage('assets/images/perfil.png'),
        ),
        SizedBox(height: 10),
        Text(
          nombreOrganizacion,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.blanco,
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
            color: AppColors.verdeLima,
          ),
        ),
      ),
    );
  }

  Widget _construirElementoLista(
      IconData icono, String titulo, VoidCallback onTap) {
    return ListTile(
        leading: Icon(icono, color: AppColors.verdeLima),
        title: Text(
          titulo,
          style: TextStyle(fontSize: 16, color: AppColors.blanco),
        ),
        trailing:
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.verdeLima),
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
          Icon(icon, color: iconColor ?? AppColors.verdeLima),
          Text(
            text,
            style: TextStyle(color: textColor ?? Colors.white),
          ),
          Icon(Icons.keyboard_arrow_right,
              color: iconColor ?? AppColors.verdeLima),
        ],
      ),
    );
  }
}
