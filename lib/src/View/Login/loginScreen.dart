import 'package:bannet_movil_t/src/View/Home/IndexScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final Color verdeLima = Color(0xFFA8C329);
  // Verde lima
  final Color grisFondo = Color(0xFFF5F5F5);
  // Fondo gris claro
  final Color grisOscuro = Color(0xFF333333);

  // Gris oscuro para detalles
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
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Usuario',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Indexscreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeLima,
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
                            backgroundColor: verdeLima,
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
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            Divider(
              color: verdeLima,
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
                  color: verdeLima,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                  onPressed: () {
                    // Acción para Facebook
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                  onPressed: () {
                    // Acción para Instagram
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.tiktok, color: Colors.white),
                  onPressed: () {
                    // Acción para TikTok
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
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
}
