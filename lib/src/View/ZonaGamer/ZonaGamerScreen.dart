import 'package:bannet_movil_t/src/Controllers/Contrato/Contrato_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/Login/Login_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/TipoServicio/TipoServicio_Controller.dart';
import 'package:bannet_movil_t/src/Controllers/postventa_controller.dart';
import 'package:bannet_movil_t/src/Models/contrato_model.dart';
import 'package:bannet_movil_t/src/Models/postventa_model.dart';
import 'package:bannet_movil_t/src/utils/constants/app_colors.dart';
import 'package:bannet_movil_t/src/widget/AlertshowModalBottomSheet.dart';
import 'package:bannet_movil_t/src/widget/dropdown_custom_form_widget.dart';
import 'package:bannet_movil_t/src/widget/terminos_Section_widget.dart';
import 'package:bannet_movil_t/src/widget/textfield_custom_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZonaGamerScreen extends StatefulWidget {
  final int? iDOrganizacion;

  const ZonaGamerScreen({super.key, this.iDOrganizacion});

  @override
  State<ZonaGamerScreen> createState() => _ZonaGamerScreenState();
}

class _ZonaGamerScreenState extends State<ZonaGamerScreen> {
  final LoginController _logincontroller = LoginController();

  final GlobalKey<FormFieldState> _contratoDropdownKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _tiposervicioDropdownKey =
      GlobalKey<FormFieldState>();
  late TextEditingController _textsolicitudController;

  bool _aceptaTerminos = false;
  int idOrganizacion = 0;
  bool _isLoading = false;

  int? _selectedContratoId;
  int? _selectedCategoriaTicketid;

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
  }

  Future<void> _initialize() async {
    await _loadUserData(); // Espera a que _loadUserData se complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contratoController =
          Provider.of<ContratoController>(context, listen: false);
      contratoController.fetchContratos(idOrganizacion);

      final postventaController =
          Provider.of<PostventaController>(context, listen: false);
      postventaController.fetchPostventaGamer();
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
      PostventaController postVentaController) async {
    final istiposervicioValid =
        _tiposervicioDropdownKey.currentState?.validate() ?? false;
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
    final postventa = PostventaModel(
      idServicioContratado: int.parse(_selectedContratoId.toString()),
      idCategoriaTicket: int.parse(_selectedCategoriaTicketid.toString()),
      observacion: _textsolicitudController.text,
    );
    final response = await postVentaController.registrarPostventa(postventa);

    mostrarNotificacion(
      context: context,
      titulo: 'Solicitud enviada',
      mensaje: response['message'],
    );

    mostrarNotificacion(
      context: context,
      titulo: 'Solicitud enviada',
      mensaje: 'message',
    );

    // Procesar la solicitud aquí
    // _limpiarFormulario();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final contratoController = Provider.of<ContratoController>(context);
    final postVentaController = Provider.of<PostventaController>(context);

    return Scaffold(
      backgroundColor: AppColors.negro,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_miportal.png',
          height: 55,
        ),
        toolbarHeight: 60,
        backgroundColor: AppColors.negro,
        centerTitle: true, // Garantiza que el título esté centrado
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
                    "Zona Gamer",
                    style: TextStyle(
                        color: AppColors.verdeLima,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
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
                DropdowncustomFormWidget<PostventaModel>(
                  fondoColor: Color(0xFFA5CD39),
                  borderColor: Colors.white,
                  labelColor: Colors.black,
                  textColor: Colors.black,
                  label: 'Tipo de Servicio',
                  hint: 'Selecciona un postventaGamer',
                  value: postVentaController.postventaGamer.firstWhere(
                    (postventaGamer) =>
                        postventaGamer.idCategoriaTicket ==
                        _selectedCategoriaTicketid,
                    orElse: () =>
                        PostventaModel.empty(), // Retornar el objeto vacío
                  ),
                  items: postVentaController.postventaGamer,
                  onChanged: (PostventaModel? newValue) {
                    _isLoading = true;

                    setState(() {
                      _selectedCategoriaTicketid = newValue?.idCategoriaTicket;
                      //contratoController.fetchContratos(_selectedContratoId!);
                      //_contratoDropdownKey.currentState?.reset();
                    });
                    //_selectedContratoId = null;
                    //_contratoDropdownKey.currentState?.reset();
                    _isLoading = false;
                  },
                  itemLabel: (contrato) =>
                      contrato.descripcionCategoriaTicket ?? '',
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un tipo de servicio';
                    }
                    return null;
                  },
                  formFieldKey: _tiposervicioDropdownKey,
                ),
                SizedBox(height: 30),
                // DropdowncustomFormWidget<String>(
                //   label: 'Tipo de Servicio',
                //   hint: 'Selecciona un tipo de servicio',
                //   value: selectedValue2,
                //   items: dropdownItems2,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       selectedValue2 = newValue;
                //     });
                //   },
                //   itemLabel: (String item) => item,
                //   validator: (String? value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Por favor selecciona un tipo de servicio';
                //     }
                //     return null;
                //   },
                //   formFieldKey: _tiposervicioDropdownKey,
                // ),
                // SizedBox(height: 30),
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
                    onPressed: () =>
                        _validarYEnviarFormulario(postVentaController),
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
