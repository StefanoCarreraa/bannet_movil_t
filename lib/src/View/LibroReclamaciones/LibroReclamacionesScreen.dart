import 'package:bannet_movil_t/src/Controllers/Contrato/Contrato_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Models/contrato_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/dropdown_custom_form_widget.dart';
import 'package:bannet_movil_t/src/widget/terminos_Section_widget.dart';
import 'package:bannet_movil_t/src/widget/textfield_custom_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibroReclamacionesScreen extends StatefulWidget {
  final int? iDOrganizacion;

  const LibroReclamacionesScreen({super.key, this.iDOrganizacion});

  @override
  State<LibroReclamacionesScreen> createState() => _LibroReclamacionesScreen();
}

class _LibroReclamacionesScreen extends State<LibroReclamacionesScreen> {
  final LoginController _logincontroller = LoginController();

  final GlobalKey<FormFieldState> _contratoDropdownKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _tipoDropdownKey =
      GlobalKey<FormFieldState>();
  late TextEditingController _textsolicitudController;
  late TextEditingController _textnombreController;
  late TextEditingController _textdocController;

  bool _aceptaTerminos = false;
  int idOrganizacion = 0;
  bool _isLoading = false; // Indicador de estado para guardar
  int? _selectedContratoId = 0;

  Future<void> _loadUserData() async {
    final userData = await _logincontroller.loadUserData();
    setState(() {
      idOrganizacion = userData['idOrganizacion'];
      setState(() {});
      ();
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();

    _textsolicitudController = TextEditingController();
    _textnombreController = TextEditingController();
    _textdocController = TextEditingController();
  }

  Future<void> _initialize() async {
    await _loadUserData(); // Espera a que _loadUserData se complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contratoController =
          Provider.of<ContratoController>(context, listen: false);
      contratoController.fetchContratos(idOrganizacion);
    });
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
        _tipoDropdownKey.currentState?.validate() ?? false;
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
        backgroundColor: AppColors.verdeLima,
      ),
    );

    // Procesar la solicitud aquí
    // _limpiarFormulario();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final contratoController = Provider.of<ContratoController>(context);

    String? selectedValue2;

    final List<String> dropdownItems2 = [
      'Reclamo',
      'Queja',
    ];

    return Scaffold(
      backgroundColor: AppColors.negro,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_miportal.png',
          height: 55,
        ),
        toolbarHeight: 60,
        backgroundColor: AppColors.negro,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.verdeLima),
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
                    "Libro de Reclamaciones",
                    style: TextStyle(
                        color: AppColors.verdeLima,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 30),
                TextfieldcustomFormWidget(
                  label: 'Nombre del titular',
                  controller: _textnombreController,
                  hintText: 'Ingrese nombre del titular',
                  min: 1,
                  max: 2,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '**Este campo es obligatorio**';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextfieldcustomFormWidget(
                  label: 'DNI/CE del titular',
                  controller: _textdocController,
                  hintText: 'Ingrese DNI/CE del titular',
                  min: 1,
                  max: 2,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '**Este campo es obligatorio**';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                DropdowncustomFormWidget<ContratoModel>(
                  fondoColor: Color(0xFFA5CD39),
                  borderColor: Colors.white,
                  labelColor: Colors.black,
                  textColor: Colors.black,
                  label: 'Contrato',
                  hint: 'Selecciona un contrato',
                  value: contratoController.contratos.firstWhere(
                    (contrato) =>
                        contrato.iDServicioContratado == _selectedContratoId,
                    orElse: () =>
                        ContratoModel.empty(), // Retornar el objeto vacío
                  ),
                  items: contratoController.contratos,
                  onChanged: (ContratoModel? newValue) {
                    _isLoading = true;

                    setState(() {
                      _selectedContratoId = newValue?.iDServicioContratado;
                      //contratoController.fetchContratos(_selectedContratoId!);
                      //_contratoDropdownKey.currentState?.reset();
                    });
                    //_selectedContratoId = null;
                    //_contratoDropdownKey.currentState?.reset();
                    _isLoading = false;
                  },
                  itemLabel: (contrato) => contrato.nombreServicio,
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un contrato';
                    }
                    return null;
                  },
                  formFieldKey: _contratoDropdownKey,
                ),
                SizedBox(height: 30),
                DropdowncustomFormWidget<String>(
                  label: 'Tipo',
                  hint: 'Selecciona un tipo',
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
                      return 'Por favor selecciona un tipo';
                    }
                    return null;
                  },
                  formFieldKey: _tipoDropdownKey,
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
                        color: _aceptaTerminos
                            ? AppColors.verdeLima
                            : AppColors.grisFondo,
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
                            color: AppColors.grisFondo,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Políticas de Privacidad',
                              style: TextStyle(
                                color: AppColors.verdeLima,
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
                                color: AppColors.grisFondo,
                              ),
                            ),
                            TextSpan(
                              text: 'Términos y Condiciones.',
                              style: TextStyle(
                                color: AppColors.verdeLima,
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
                      backgroundColor: AppColors.verdeLima,
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
