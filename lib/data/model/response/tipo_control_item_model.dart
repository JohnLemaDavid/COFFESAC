import 'dart:convert';

/**
 * Creado por Patricio Landa el 9/11/2023.
 * Cooperativa Sac
 * alanda@coopsac.fin.ec
 */

List<TipoControlProspectoItemOutPutModel> tipoControlProspectoModelFromJson(String str) => List<TipoControlProspectoItemOutPutModel>.from(json.decode(str).map((x) => TipoControlProspectoItemOutPutModel.fromJson(x)));

String tipoControlProspectoModelToJson(List<TipoControlProspectoItemOutPutModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoControlProspectoItemOutPutModel {
  final String? codigo;
  final String? nombre;
  const TipoControlProspectoItemOutPutModel({
    required this.codigo,
    required this.nombre
  });
  factory TipoControlProspectoItemOutPutModel.fromJson(Map<String, dynamic> json) {
    return TipoControlProspectoItemOutPutModel(
      codigo: json['codigo'] as String,
      nombre: json['nombre'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
    'codigo' : codigo,
    'nombre': nombre
  };
}
// A function that converts a response body into a List<Photo>.
List<TipoControlProspectoItemOutPutModel> parsePhotos(String responseBody) {
  final parsed =
  (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<TipoControlProspectoItemOutPutModel>((json) => TipoControlProspectoItemOutPutModel.fromJson(json)).toList();
}
/**class TipoControlProspectoOutPutModel {
  List<TipoControlProspectoItemOutPutModel>? Lista;
  TipoControlProspectoOutPutModel({
    this.Lista
  });
  TipoControlProspectoOutPutModel.fromJson(Map<String, dynamic> json) {
   // Lista = json['Lista'];
    json['Lista'].forEach((v) {
      Lista!.add(TipoControlProspectoItemOutPutModel.fromJson(v));
    });
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Lista'] = Lista!.map((v) => v.toJson()).toList();
    return data;
  }
}*/
