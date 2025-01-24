class TipoServicioModel {
  final int iDCategoriaTicket;
  final String descripcionCategoriaTicket;

  TipoServicioModel({
    required this.iDCategoriaTicket,
    required this.descripcionCategoriaTicket,
  });

  TipoServicioModel.empty() : iDCategoriaTicket = 0, descripcionCategoriaTicket = 'Sin Categoría';
  
  factory TipoServicioModel.fromJson(Map<String, dynamic> json) {
    return TipoServicioModel(
      iDCategoriaTicket: json['IDCategoriaTicket'],
      descripcionCategoriaTicket: json['DescripcionCategoriaTicket'],
    );
  }

  static List<TipoServicioModel> listFromJson(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => TipoServicioModel.fromJson(json)).toList();
  }
}