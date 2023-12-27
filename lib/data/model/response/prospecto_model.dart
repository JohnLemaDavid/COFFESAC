/**
 * Creado por Patricio Landa el 9/11/2023.
 * Cooperativa Sac
 * alanda@coopsac.fin.ec
 */
class ProspectoInputModel{
  String? Identificacion;
  String? Nombre;
  String? Telefono;
  String? FechaSistema;
  String? FechaProceso;
  String? CodigoUsuario;
  String? CodigoTipoControl;

  ProspectoInputModel({
      this.Identificacion,
      this.Nombre,
      this.Telefono,
      this.FechaSistema,
      this.FechaProceso,
      this.CodigoUsuario,
      this.CodigoTipoControl});
  ProspectoInputModel.fromJson(Map<String, dynamic> json) {
    Identificacion = json['Identificacion'];
    Nombre = json['Nombre'];
    Telefono = json['Telefono'];
    FechaSistema = json['FechaSistema'];
    FechaProceso = json['FechaProceso'];
    CodigoUsuario = json['CodigoUsuario'];
    CodigoTipoControl = json['CodigoTipoControl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Identificacion'] = Identificacion;
    data['Nombre'] = Nombre;
    data['Telefono']= Telefono;
    data['FechaSistema']= FechaSistema;
    data['FechaProceso']= FechaProceso;
    data['CodigoUsuario']= CodigoUsuario;
    data['CodigoTipoControl']= CodigoTipoControl;
    return data;
  }
}