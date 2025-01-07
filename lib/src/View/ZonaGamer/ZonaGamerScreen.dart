import 'package:bannet_movil_t/src/widget/dropdown_custom_form_widget.dart';
import 'package:bannet_movil_t/src/widget/textfield_custom_form_widget.dart';
import 'package:flutter/material.dart';

class ZonaGamerScreen extends StatefulWidget {
  ZonaGamerScreen({super.key});

  @override
  State<ZonaGamerScreen> createState() => _ZonaGamerScreenState();
}

class _ZonaGamerScreenState extends State<ZonaGamerScreen> {
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

  void _mostrarTerminosYCondiciones() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Términos y Condiciones'),
          content: Container(
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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _aceptaTerminos = true;
                });
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: verdeLima,
              ),
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
      'Cambio de IP',
      'Servicio 2',
      'Servicio 3',
      'Servicio 4',
      'Servicio 5',
      'Servicio 6',
    ];

    return Scaffold(
      backgroundColor: negro,
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/logo_bannet_1.png',
            height: 30,
          ),
        ),
        toolbarHeight: 60,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh, color: verdeLima),
          ),
        ],
        backgroundColor: negro,
        centerTitle: true,
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
                    "Zona Gamer",
                    style: TextStyle(
                        color: verdeLima,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 30),
                DropdowncustomFormWidget<String>(
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
                    Checkbox(
                      value: _aceptaTerminos,
                      onChanged: (bool? value) {
                        if (value == true) {
                          _mostrarTerminosYCondiciones();
                        } else {
                          setState(() {
                            _aceptaTerminos = false;
                          });
                        }
                      },
                      fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return verdeLima; // Color cuando está activado
                          }
                          return grisFondo; // Color cuando está desactivado
                        },
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Al hacer click en el botón “SOLICITAR”, aceptas nuestras Políticas de Privacidad y Términos y Condiciones.',
                        style: TextStyle(
                          color: grisFondo,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final istiposervicioValid =
                          _tiposervicioDropdownKey.currentState?.validate() ??
                              false;
                      final iscontratoValid =
                          _contratoDropdownKey.currentState?.validate() ??
                              false;
                      final isFormValid =
                          _formKey.currentState?.validate() ?? false;
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

                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '¡Solicitud enviada correctamente!',
                            ),
                            backgroundColor: verdeLima,
                          ),
                        );

                        // Procesar la solicitud aquí
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Por favor completa correctamente todos los campos.',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
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
}
