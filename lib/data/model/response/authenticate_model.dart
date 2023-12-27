class AuthenticateInputModel {
  String? Usuario;
  String? Clave;
  String? Maquina;
  String? IMEI;
  AuthenticateInputModel({
    this.Usuario,
    this.Clave,
    this.Maquina,
    this.IMEI
  });
  AuthenticateInputModel.fromJson(Map<String, dynamic> json) {
    Usuario = json['Usuario'];
    Clave = json['Clave'];
    Maquina = json['Maquina'];
    IMEI = json['IMEI'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Usuario'] = Usuario;
    data['Clave'] = Clave;
    data['Maquina'] = Maquina;
    data['IMEI'] = IMEI;
    return data;
  }
}

class AuthenticateOutputModel {
  String? usuario;
  String? nombre;
  String? fechaSistema;
  String? token;
  AuthenticateOutputModel({
    this.usuario,
    this.nombre,
    this.fechaSistema,
    this.token
  });
  AuthenticateOutputModel.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'];
    nombre = json['nombre'];
    fechaSistema = json['fechaSistema'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usuario'] = usuario;
    data['nombre'] = nombre;
    data['fechaSistema'] = fechaSistema;
    data['token'] = token;
    return data;
  }
}