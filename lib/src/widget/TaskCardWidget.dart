import 'package:bannet_movil_t/src/View/Recibo/ReciboScreen.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatefulWidget {
  final String? titulo;
  final String? subtitulo;
  final String? periodo;
  final String? fecha;
  final String? estado;
  final String? precio;
  final Color? color;
  final bool isCompleted;
  final Widget? expandedContent; // Nuevo parámetro para contenido expandido

  const TaskCardWidget({
    super.key,
    this.titulo,
    this.fecha,
    this.precio,
    this.estado,
    this.color,
    required this.isCompleted,
    this.subtitulo,
    this.periodo,
    this.expandedContent, // Inicialización del nuevo parámetro
  });

  @override
  _TaskCardWidgetState createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  bool _isExpanded = false; // Controla si el panel está expandido o no

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // Cambiar estado de expansión
        });
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Contenedor de la tarea
            Row(
              children: [
                Container(
                  width: 8,
                  height: 150,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.titulo!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      if (widget.subtitulo != null) ...[
                        SizedBox(
                            height: 4), // Espaciado entre el título y subtítulo
                        Text(
                          widget.subtitulo!,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                      if (widget.periodo != null) ...[
                        SizedBox(
                            height: 4), // Espaciado entre el título y subtítulo
                        Text(
                          widget.periodo!,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                      if (widget.precio != null) ...[
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 14, color: Colors.white54),
                            SizedBox(width: 4),
                            Text(
                              widget.precio!,
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                      if (widget.estado != null) ...[
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 14, color: Colors.white54),
                            SizedBox(width: 4),
                            Text(
                              widget.estado!,
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                      if (widget.fecha != null) ...[
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 14, color: Colors.white54),
                            SizedBox(width: 4),
                            Text(
                              widget.fecha!,
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),

            // Mostrar contenido expandido
            if (_isExpanded)
              widget.expandedContent ??
                  _buildMiRecibo(), // Usa el contenido proporcionado o el predeterminado
          ],
        ),
      ),
    );
  }

  // Función para construir el Recibo expandido
  Widget _buildMiRecibo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.receipt_long_outlined, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                '¿Qué quieres hacer hoy?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoton('Ver recibo', Colors.white, AppColors.negro, true),
            ],
          ),
        ],
      ),
    );
  }

// Botón de acción
  Widget _buildBoton(
      String texto, Color colorFondo, Color colorTexto, bool conBorde) {
    return Builder(
      builder: (BuildContext context) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colorFondo,
            foregroundColor: colorTexto,
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: conBorde
                  ? BorderSide(color: Colors.black12, width: 2)
                  : BorderSide.none,
            ),
          ),
          onPressed: () {
            if (texto == 'Ver recibo') {
              // Navegar a la pantalla del recibo
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReciboScreen("")),
              );
            } else {}
          },
          child: Text(
            texto,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: colorTexto),
          ),
        );
      },
    );
  }
}
