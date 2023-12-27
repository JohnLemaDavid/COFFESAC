import 'dart:ffi';

class PuntoAzulInputModel{
  String? Proceso;
  String? Codigo;
  String? Identificacion;
  PuntoAzulInputModel({
    this.Proceso,
    this.Codigo,
    this.Identificacion
  });
  PuntoAzulInputModel.fromJson(Map<String, dynamic> json) {
    Proceso = json['Proceso'];
    Codigo = json['Codigo'];
    Identificacion = json['Identificacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Proceso'] = Proceso;
    data['Codigo'] = Codigo;
    data['Identificacion'] = Identificacion;
    return data;
  }
}

class PuntoAzulOutPutModel{
  bool? success;
  String? status;
  String? message;
  SaldoPuntoAzulModel? data;
  PuntoAzulOutPutModel(bool parse, String string,String mensaje_, body, {
  this.success,
  this.status,
  this.message,
  this.data
  });
  PuntoAzulOutPutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'].toSaldoPuntoAzulModel();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datos = <String, dynamic>{};
    datos['success'] = success;
    datos['status'] = status;
    datos['message'] = message;
    datos['data'] = data;
    return datos;
  }
}
class SaldoPuntoAzulModel {
  double? saldo;
  SaldoPuntoAzulModel({
    this.saldo
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saldo'] = saldo;
    return data;
  }
  SaldoPuntoAzulModel.fromJson(Map<String, dynamic> json) {
    saldo = json['saldo'].toDouble();
  }
}

class PuntoAzulProcesoInputModel{
  String? Proceso;
  String? Codigo;
  String? Identificacion;
  String? Observacion;
  double? Valor;
  String? EstadoTarjeta;
  bool? EsTarjetaCortesia;
  PuntoAzulProcesoInputModel({
    this.Proceso,
    this.Codigo,
    this.Identificacion,
    this.Observacion,
    this.Valor,
    this.EstadoTarjeta,
    this.EsTarjetaCortesia
  });
  PuntoAzulProcesoInputModel.fromJson(Map<String, dynamic> json) {
    Proceso = json['Proceso'];
    Codigo = json['Codigo'];
    Identificacion = json['Identificacion'];
    Observacion = json['Observacion'];
    Valor = json['Valor'];
    EstadoTarjeta = json['EstadoTarjeta'];
    EsTarjetaCortesia = json['EsTarjetaCortesia'].toBoolean();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Proceso'] = Proceso;
    data['Codigo'] = Codigo;
    data['Identificacion'] = Identificacion;
    data['Observacion'] = Observacion;
    data['Valor'] = Valor;
    data['EstadoTarjeta'] = EstadoTarjeta;
    data['EsTarjetaCortesia'] = EsTarjetaCortesia;
    return data;
  }
}

class PuntoAzulCortesiaOutputModel{
  int? id;
  double? puntos;
  double? saldo;
  PuntoAzulCortesiaOutputModel({
    this.id,this.puntos,this.saldo
  });
  PuntoAzulCortesiaOutputModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    puntos = double.parse(json['puntos'].toString());
    saldo = double.parse(json['saldo'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['puntos'] = puntos;
    data['saldo'] = saldo;
    return data;
  }
}
