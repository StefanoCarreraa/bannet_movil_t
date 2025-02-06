import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

void mostrarNotificacion({
  required BuildContext context,
  required String titulo,
  required String mensaje,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Permite que el contenido se ajuste
    isDismissible: false, // No cierra al hacer clic fuera
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centra el Row
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                    width: 10), // Espaciado entre el icono y el texto
                Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Cerrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
