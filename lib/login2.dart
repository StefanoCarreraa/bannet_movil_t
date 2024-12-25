// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false; // Estado de visibilidad de contraseña

  @override
  void initState() {
    super.initState();
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

  Future<void> _loginDirecto(BuildContext context) async {
    // Credenciales predeterminadas
    String loginUsuario = 'GROJAS';
    String claveUsuario = 'D@nnicol3';

    _showSnackBar(context, 'Intentando iniciar sesión con: $loginUsuario');

    // _showSnackBar(
    //     context, 'Finalizado intento de inicio de sesión con: $loginUsuario');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            const HeaderContainer("Login"),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Inicia sesión para continuar',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: 'MyCustomFont',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    _buildTextField(
                      label: 'Usuario',
                      controller: _usuarioController,
                      hint: 'Escriba su Usuario',
                      prefixIcon: Icons.account_circle_outlined,
                    ),
                    const SizedBox(height: 20),
                    // _buildTextField(
                    //     label: 'Contraseña',
                    //     controller: _claveController,
                    //     hint: 'Escriba su Contraseña',
                    //     isPassword: true,
                    //     prefixIcon: Icons.key,
                    //     suffixIcon: Icons.visibility),

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
                    const SizedBox(height: 70),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          backgroundColor: const Color(0xffB3D818),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Color(0xff070707), width: 2),
                          ),
                        ),
                        onPressed: () {},
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Color(0xff070707))
                            : const Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff070707),
                                    fontFamily: 'MyCustomFont',
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: _isLoading
                    //         ? null
                    //         : () async {
                    //             setState(() => _isLoading = true);
                    //             await _loginDirecto(context);
                    //             setState(() => _isLoading = false);
                    //           },
                    //     style: ElevatedButton.styleFrom(
                    //       padding: const EdgeInsets.symmetric(vertical: 25),
                    //       backgroundColor: const Color.fromARGB(
                    //           255, 0, 0, 0), // Color del botón
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         side: const BorderSide(
                    //             color: Color(0xff070707), width: 2),
                    //       ),
                    //     ),
                    //     child: _isLoading
                    //         ? const CircularProgressIndicator(
                    //             color: Color(0xff070707))
                    //         : const Text(
                    //             'Acceso Directo',
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Colors.white, // Color del texto
                    //                 fontFamily: 'MyCustomFont',
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xff070707)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color(0xff070707))
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: const Color(0xff070707)),
                onPressed: onSuffixIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffB3D818), width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffB3D818), width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xff070707), width: 2),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class HeaderContainer extends StatelessWidget {
  final String text;
  const HeaderContainer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff070707), Color(0xff070707)],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            right: 20,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'MyCustomFont',
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Bienvenido!!!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MyCustomFont',
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset("assets/images/logo_bannet_1.png", height: 50,),
          ),
        ],
      ),
    );
  }
}
