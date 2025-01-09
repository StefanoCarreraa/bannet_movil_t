import 'package:flutter/material.dart';

class TerminosYCondicionesDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final Color acceptButtonColor;

  const TerminosYCondicionesDialog({
    super.key,
    required this.onAccept,
    this.acceptButtonColor = const Color(0xFFA5CD39), // Color predeterminado
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Al cerrar el diálogo (con botón de cerrar), consideramos como aceptado
        onAccept();
        return true;
      },
      child: AlertDialog(
        title: Text('Términos y Condiciones'),
        content: SizedBox(
          height: 300, // Altura fija para el contenido con scroll
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. **Aceptación de Términos:**\nAl utilizar esta aplicación, aceptas cumplir con estos términos y condiciones.',
                ),
                SizedBox(height: 10),
                Text(
                  '2. **Uso Adecuado:**\nNo debes utilizar la aplicación para fines ilícitos o no autorizados.',
                ),
                SizedBox(height: 10),
                Text(
                  '3. **Protección de Datos:**\nTus datos serán protegidos según las leyes de privacidad vigentes.',
                ),
                SizedBox(height: 10),
                Text(
                  '4. **Actualizaciones:**\nNos reservamos el derecho de modificar estos términos en cualquier momento.',
                ),
                SizedBox(height: 10),
                Text(
                  '5. **Responsabilidad Limitada:**\nNo nos hacemos responsables por daños derivados del uso incorrecto de la aplicación.',
                ),
                SizedBox(height: 10),
                Text(
                  '6. **Contacto:**\nPara cualquier consulta, puedes contactarnos a soporte@example.com.',
                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              onAccept();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: acceptButtonColor,
            ),
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
