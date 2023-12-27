import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:efood_table_booking/util/app_constants.dart';
import 'package:efood_table_booking/data/api/api_client.dart';
import 'package:efood_table_booking/data/model/response/punto_azul_model.dart';
import 'package:efood_table_booking/data/model/response/authenticate_model.dart';

import '../model/response/prospecto_model.dart';

class PuntoAzulRepo {
  final ApiClient apiClient;
  //final SharedPreferences sharedPreferences;
  PuntoAzulRepo({required this.apiClient});

  Future<Response> postConsultaPuntosAzules(PuntoAzulInputModel PuntoAzulInputmodel) async {
    return await apiClient.postDataPuntosAzules('${AppConstants.consultaPuntoAzulUri}', PuntoAzulInputmodel.toJson());
  }
  Future<Response> postCreditoPuntosAzules(PuntoAzulProcesoInputModel puntoAzulProcesoInputModel) async {
    return await apiClient.postDataPuntosAzules('${AppConstants.consultaPuntoAzulUri}', puntoAzulProcesoInputModel.toJson());
  }
  Future<Response> postAutenticaPuntosAzules(AuthenticateInputModel authenticateInputModel) async {
    return await apiClient.postDataPuntosAzules('${AppConstants.coffeeSacAutentica}', authenticateInputModel.toJson());
  }
  Future<Response> postGuardaProspecto(ProspectoInputModel prospectoInputModel) async {
    return await apiClient.postProspectoGenerico('${AppConstants.coffeeSacGuardaProspecto}', prospectoInputModel.toJson());
  }
  Future<Response> postConsultaTipoControlProspecto() async {
    return await apiClient.postProspectoGenerico('${AppConstants.coffeeSacConsultaTipoControlProspecto}', null);
  }

  Future<Response> postConsultaPuntosCortesia() async {
    return await apiClient.postDataPuntosAzules('${AppConstants.consultaPuntoCortesiaUri}', null);
  }
}