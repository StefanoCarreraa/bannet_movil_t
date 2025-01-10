import 'package:bannet_movil_t/src/widget/dropdown_custom_form_widget.dart';
import 'package:bannet_movil_t/src/widget/terminos_Section_widget.dart';
import 'package:bannet_movil_t/src/widget/textfield_custom_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PostVentaScreen extends StatefulWidget {
  PostVentaScreen({super.key});

  @override
  State<PostVentaScreen> createState() => _PostVentaScreenState();
}

class _PostVentaScreenState extends State<PostVentaScreen> {
  final Color verdeLima = Color(0xFFA5CD39);
  final Color grisFondo = Color(0xFFF5F5F5);
  final Color grisOscuro = Color(0xFF333333);
  final Color negro = Color(0xFF000000);

  final GlobalKey<FormFieldState> _contratoDropdownKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _tiposervicioDropdownKey =
      GlobalKey<FormFieldState>();
  late TextEditingController _textsolicitudController;

  bool _aceptaTerminos = false;

  @override
  void initState() {
    super.initState();
    _textsolicitudController = TextEditingController();
  }

  Future<bool?> _mostrarTerminosYCondiciones() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return TerminosYCondicionesDialog(
          onAccept: () {
            Navigator.of(context).pop(true); // Devuelve "true" si acepta
          },
        );
      },
    );
  }

  void _validarYEnviarFormulario() {
    final istiposervicioValid =
        _tiposervicioDropdownKey.currentState?.validate() ?? false;
    final iscontratoValid =
        _contratoDropdownKey.currentState?.validate() ?? false;
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!_aceptaTerminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Debes aceptar las Políticas de Privacidad y Términos y Condiciones.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!isFormValid || !istiposervicioValid || !iscontratoValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Por favor completa correctamente todos los campos.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Solicitud enviada correctamente!',
        ),
        backgroundColor: verdeLima,
      ),
    );

    // Procesar la solicitud aquí
    // _limpiarFormulario();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    String? selectedValue2;

    final List<String> dropdownItems = [
      'Contrato 1',
      'Contrato 2',
      'Contrato 3',
      'Contrato 4',
      'Contrato 5',
      'Contrato 6'
    ];
    final List<String> dropdownItems2 = [
      'Servicio 1',
      'Servicio 2',
      'Servicio 3',
      'Servicio 4',
      'Servicio 5',
      'Servicio 6',
    ];

    return Scaffold(
      backgroundColor: negro,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_bannet_1.png',
          height: 30,
        ),
        toolbarHeight: 60,
        backgroundColor: negro,
        centerTitle: true, // Garantiza que el título esté centrado
        iconTheme: IconThemeData(color: verdeLima),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Bannet_Fond.jpg'),
            fit: BoxFit.cover,
          ),
          color: Color(0xFF000000),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Servicios PostVenta",
                    style: TextStyle(
                        color: verdeLima,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 30),
                DropdowncustomFormWidget<String>(
                  fondoColor: Color(0xFFA5CD39),
                  borderColor: Colors.white,
                  labelColor: Colors.black,
                  textColor: Colors.black,
                  label: 'Contrato',
                  hint: 'Selecciona un contrato',
                  value: selectedValue,
                  items: dropdownItems,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                  itemLabel: (String? item) => item ?? '',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona un contrato';
                    }
                    return null;
                  },
                  formFieldKey: _contratoDropdownKey,
                ),
                SizedBox(height: 30),
                DropdowncustomFormWidget<String>(
                  label: 'Tipo de Servicio',
                  hint: 'Selecciona un tipo de servicio',
                  value: selectedValue2,
                  items: dropdownItems2,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue2 = newValue;
                    });
                  },
                  itemLabel: (String item) => item,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona un tipo de servicio';
                    }
                    return null;
                  },
                  formFieldKey: _tiposervicioDropdownKey,
                ),
                SizedBox(height: 30),
                TextfieldcustomFormWidget(
                  label: 'Detalle de Solicitud',
                  controller: _textsolicitudController,
                  hintText: 'Ingrese detalle',
                  min: 6,
                  max: 8,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '**Este campo es obligatorio**';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        _aceptaTerminos
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: _aceptaTerminos ? verdeLima : grisFondo,
                        size: 28,
                      ),
                      onTap: () async {
                        if (_aceptaTerminos) {
                          // Si ya está seleccionado, deseleccionar al hacer clic
                          setState(() {
                            _aceptaTerminos = false;
                          });
                        } else {
                          // Mostrar el diálogo de términos y condiciones
                          final acepto = await _mostrarTerminosYCondiciones();
                          if (acepto != null && acepto) {
                            setState(() {
                              _aceptaTerminos = true;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text:
                              'Al hacer click en el botón “SOLICITAR”, aceptas nuestras ',
                          style: TextStyle(
                            color: grisFondo,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Políticas de Privacidad',
                              style: TextStyle(
                                color: verdeLima,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Lógica para mostrar las políticas de privacidad
                                  _mostrarPoliticasDePrivacidad();
                                },
                            ),
                            TextSpan(
                              text: ' y ',
                              style: TextStyle(
                                color: grisFondo,
                              ),
                            ),
                            TextSpan(
                              text: 'Términos y Condiciones.',
                              style: TextStyle(
                                color: verdeLima,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _mostrarTerminosYCondiciones();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _validarYEnviarFormulario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verdeLima,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      'SOLICITAR',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarPoliticasDePrivacidad() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Políticas de Privacidad'),
          content: Text('Aquí van las políticas de privacidad.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
