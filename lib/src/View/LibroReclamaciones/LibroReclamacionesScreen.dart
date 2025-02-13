import 'package:bannet_movil_t/src/Controllers/Contrato/Contrato_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/libroreclamacion_controller.dart';
import 'package:bannet_movil_t/src/Models/contrato_model.dart';
import 'package:bannet_movil_t/src/Models/libroReclamacion_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/AlertshowModalBottomSheet.dart';
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
  String? selectedTipoReclamo;

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

  Future<void> _validarYEnviarFormulario(
      LibroReclamacionController libroReclamacionController) async {
    final istiposervicioValid =
        _tipoDropdownKey.currentState?.validate() ?? false;
    final iscontratoValid =
        _contratoDropdownKey.currentState?.validate() ?? false;
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!_aceptaTerminos) {
      mostrarNotificacion(
        context: context,
        titulo: 'Error',
        mensaje:
            'Debes aceptar las Políticas de Privacidad y Términos y Condiciones.',
      );
      return;
    }

    if (!isFormValid || !istiposervicioValid || !iscontratoValid) {
      mostrarNotificacion(
        context: context,
        titulo: 'Error',
        mensaje: 'Por favor completa correctamente todos los campos.',
      );
      return;
    }
    final libroReclamacion = LibroReclamacionModel(
      idServicioContratado: int.parse(_selectedContratoId.toString()),
      tipoReclamo: selectedTipoReclamo.toString(),
      observacion: _textsolicitudController.text,
    );
    final response = await libroReclamacionController
        .registrarLibroReclamacion(libroReclamacion);

    mostrarNotificacion(
      context: context,
      titulo: '¡Solicitud fue enviada!',
      mensaje: response['message'],
    );

    // Procesar la solicitud aquí
    // _limpiarFormulario();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final contratoController = Provider.of<ContratoController>(context);
    final libroReclamacionController =
        Provider.of<LibroReclamacionController>(context, listen: false);

    final List<String> dropdownItems2 = [
      'RECLAMO',
      'QUEJA',
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
                SizedBox(height: 20),
                Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: AppColors.verdeLima,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Nombre: ",
                            style: TextStyle(
                              color: AppColors
                                  .verdeLima, // "Nombre" será verdeLima
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Stefano Manuel Carrera Alvarado", // El resto del texto será negro
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: AppColors.verdeLima,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "DNI/CE: ",
                            style: TextStyle(
                              color: AppColors
                                  .verdeLima, // "Nombre" será verdeLima
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: "73957264", // El resto del texto será negro
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
                SizedBox(height: 20),
                DropdowncustomFormWidget<String>(
                  label: 'Tipo',
                  hint: 'Selecciona un tipo',
                  value: selectedTipoReclamo,
                  items: dropdownItems2,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTipoReclamo = newValue;
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
                SizedBox(height: 20),
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
                SizedBox(height: 20),
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
                    onPressed: () {
                      _validarYEnviarFormulario(libroReclamacionController);
                    },
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
