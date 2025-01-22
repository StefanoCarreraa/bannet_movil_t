import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/View/Home/IndexScreen.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final LoginController _controller = LoginController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false; // Estado de visibilidad de contraseña

  @override
  void initState() {
    super.initState();
    _controller.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/Bannet_Fondo.jpg'), // Reemplaza con tu imagen
            fit: BoxFit.cover,
          ),
          color: Color(0xFF000000),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              'assets/images/logo_miportal.png',
              height: 100,
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Usuario',
                    controller: _usuarioController,
                    hint: 'Usuario',
                    isPassword: false,
                    prefixIcon: Icons.account_circle_outlined,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Contraseña',
                    controller: _claveController,
                    hint: 'Escriba su Contraseña',
                    isPassword: !_isPasswordVisible, // Cambia según el estado
                    prefixIcon: Icons.key,
                    suffixIcon: _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onSuffixIconPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  setState(() => _isLoading = true);
                                  final loginUsuario = _usuarioController.text;
                                  final claveUsuario = _claveController.text;

                                  final success =
                                      await _controller.attemptLogin(
                                          loginUsuario, claveUsuario, context);

                                  setState(() => _isLoading = false);

                                  if (!success) {
                                    _showAlertDialog(context, 'Error',
                                        'No se pudo conectar con el servidor.');
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.verdeLima,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            'Ingresar',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.verdeLima,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            'Registrarte',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                'Para recuperar contraseña, comunícate con nosotros al (01) 480 0501',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.blanco),
              ),
            ),
            SizedBox(height: 30),
            Divider(
              color: AppColors.verdeLima,
              thickness: 2,
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '¡Bienvenidos al Portal de Clientes Bantel!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.verdeLima,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook,
                      color: AppColors.blanco),
                  onPressed: () {
                    // Acción para Facebook
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram,
                      color: AppColors.blanco),
                  onPressed: () {
                    // Acción para Instagram
                  },
                ),
                IconButton(
                  icon:
                      FaIcon(FontAwesomeIcons.tiktok, color: AppColors.blanco),
                  onPressed: () {
                    // Acción para TikTok
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin,
                      color: AppColors.blanco),
                  onPressed: () {
                    // Acción para LinkedIn
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
  }) {
    Color negro = Color(0xff070707);
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: negro),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: negro) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: negro),
                onPressed: onSuffixIconPressed,
              )
            : null,
        fillColor: AppColors.blanco, // Fondo blanco
        filled: true, // Activar el fondo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.verdeLima, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.verdeLima, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: negro, width: 2),
        ),
      ),
    );
  }
}
