import 'dart:convert';

import 'package:efood_table_booking/data/model/response/authenticate_model.dart';
import 'package:efood_table_booking/util/app_constants.dart';
import 'package:efood_table_booking/view/screens/home/home_screen.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:efood_table_booking/data/repository/punto_azul_repo.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:efood_table_booking/data/model/response/punto_azul_model.dart';
import 'package:efood_table_booking/helper/route_helper.dart';
import 'package:efood_table_booking/util/widget/loading_indicator_dialog.dart';
import 'package:efood_table_booking/view/screens/splash/splash_screen.dart';

import '../data/model/response/prospecto_model.dart';
import '../data/model/response/tipo_control_item_model.dart';
class PuntoAzulController extends GetxController implements GetxService {
  final PuntoAzulRepo puntoAzulRepo;
  final SharedPreferences sharedPreferences;
  PuntoAzulController({required this.puntoAzulRepo,required this.sharedPreferences});

  AuthenticateInputModel? _authenticateInputModel;
  AuthenticateOutputModel? _authenticateOutputModel;
  bool _isLoading = false;
  PuntoAzulInputModel? _puntoAzulInputModel;
  PuntoAzulOutPutModel? _puntoAzulOutputModel;
  PuntoAzulCortesiaOutputModel? _puntoAzulCortesiaOutputModel;
  List<TipoControlProspectoItemOutPutModel>? _listaTipoControl;


  List<TipoControlProspectoItemOutPutModel>? get listaTipoControl => _listaTipoControl;
  AuthenticateInputModel? get authenticateInputModel => _authenticateInputModel;
  AuthenticateOutputModel? get authenticateOutputModel => _authenticateOutputModel;
  PuntoAzulInputModel? get puntoAzulInputModel => _puntoAzulInputModel;
  PuntoAzulOutPutModel? get puntoAzulOutputModel => _puntoAzulOutputModel;
  PuntoAzulCortesiaOutputModel? get puntoAzulCortesiaOutputModel => _puntoAzulCortesiaOutputModel;
  //TipoControlProspectoOutPutModel? get tipoControlProspectoOutPutModel => _tipoControlProspectoOutPutModel;
  bool get isLoading => _isLoading;

  set setAuthenticateInputModel(AuthenticateInputModel authenticateInputModelValue){
    _authenticateInputModel = authenticateInputModelValue;
  }
  set setAuthenticateOutputModel(AuthenticateOutputModel authenticateOutputModelValue){
    _authenticateOutputModel = authenticateOutputModelValue;
  }
  set setPuntoAzulInputModel(PuntoAzulInputModel puntoAzulInputModelValue){
    _puntoAzulInputModel = puntoAzulInputModelValue;
  }
  set setPuntoAzulOutputModel(PuntoAzulOutPutModel puntoAzulOutPutModelValue){
    _puntoAzulOutputModel = puntoAzulOutPutModelValue;
  }
  set setTipoControlProspectoOutPutModel(List<TipoControlProspectoItemOutPutModel> tipoControlProspectoOutPutModelValue){
    _listaTipoControl = tipoControlProspectoOutPutModelValue;
  }
  set isLoadingUpdate(bool isLoad) {
    _isLoading = isLoad;
  }
  set setPuntoAzulCortesiaOutputModel(PuntoAzulCortesiaOutputModel puntoAzulCortesiaOutputModelValue){
    _puntoAzulCortesiaOutputModel = puntoAzulCortesiaOutputModelValue;
  }

  Future<void> authenticate(AuthenticateInputModel authenticateInputModel,BuildContext context) async {
    LoadingIndicatorDialog().show(context);
    Response response = await puntoAzulRepo.postAutenticaPuntosAzules(authenticateInputModel);
    LoadingIndicatorDialog().dismiss();
    if (response.statusCode == 200) {
      String token = response.body['token'].toString();
      String usuarioCodigo = response.body['usuario'].toString();
      _authenticateOutputModel = AuthenticateOutputModel(
        usuario: usuarioCodigo,
        nombre: response.body['nombre'],
        fechaSistema: response.body['fechaSistema'],
        token: response.body['token'],
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
      sharedPreferences.setString(AppConstants.tokenPuntoAzul, token);
      sharedPreferences.setString(AppConstants.codigoUsuarioLogin, usuarioCodigo);
    }
    else {
      try{
        var excepcion = (response.body['excepcion']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );
      }catch(exception){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppConstants.errorRed),backgroundColor: Colors.redAccent,),);
      }
    }
  }
  Future<String> consultaPuntoAzul(PuntoAzulInputModel puntoAzulInputModel,BuildContext context,bool mostrarMensaje) async {
    //LoadingIndicatorDialog().show(context);
    _isLoading = true;
    update();
    Response response = await puntoAzulRepo.postConsultaPuntosAzules(puntoAzulInputModel);
    //LoadingIndicatorDialog().dismiss();
    //CircularProgressIndicator();
    _isLoading = false;

    var saldo = '';
    if (response.statusCode == 200) {
      if(bool.parse(response.body['success'].toString())){
        var resultado = (response.body['data']);
        var mensaje = (response.body['message'].toString());
        saldo = resultado["saldo"].toString();
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje),backgroundColor: Colors.blueAccent,),
        );*/
        if(mostrarMensaje){
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Aviso'),
              content:  Text(mensaje),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Aceptar'),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          );
        }

      }
      else {
        var excepcion = (response.body['message']);
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(excepcion),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );*/
      }
    } else {
      try{
        var excepcion = (response.body['excepcion']);
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );*/

          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Aviso'),
              content:  Text(excepcion),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Aceptar'),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          );


      }catch(exception){
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.errorRed),backgroundColor: Colors.redAccent,),);*/
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(AppConstants.errorRed),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
    }
      update();
  }
    return saldo;
}

  Future<void> creditoPuntoAzul(PuntoAzulProcesoInputModel puntoAzulProcesoInputModel,BuildContext context) async {
    //LoadingIndicatorDialog().show(context);
    /**if(!LoadingIndicatorDialog().){
      LoadingIndicatorDialog().show(context);
    }*/
    Response response = await puntoAzulRepo.postCreditoPuntosAzules(puntoAzulProcesoInputModel);
    /**if(LoadingIndicatorDialog().isDisplayed){
      LoadingIndicatorDialog().dismiss();
    }*/
    if (response.statusCode == 200) {
      if(bool.parse(response.body['success'].toString())){
        var mensaje = (response.body['message'].toString());
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(mensaje),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje),backgroundColor: Colors.blueAccent,),
        );*/
      }
      else {
        var excepcion = (response.body['message']);
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );*/
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(excepcion),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }
    } else {
      try{
        var excepcion = (response.body['excepcion']);
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );*/
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(excepcion),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }catch(exception){
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.errorRed),backgroundColor: Colors.redAccent,),);*/
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(AppConstants.errorRed),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }
    }
  }
  Future<void> guardaDatosProspecto(ProspectoInputModel prospectoInputModel,BuildContext context) async {
    //LoadingIndicatorDialog().show(context);
    Response response = await puntoAzulRepo.postGuardaProspecto(prospectoInputModel);
    //LoadingIndicatorDialog().dismiss();
    if (response.statusCode == 200) {
      /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.guardadoCorrectamente),backgroundColor: Colors.blueAccent)
      );*/
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Aviso'),
          content:  Text(AppConstants.guardadoCorrectamente),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Aceptar'),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );

      /**if(bool.parse(response.body['success'].toString())){
        var mensaje = (response.body['message'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje),backgroundColor: Colors.blueAccent,),
        );
      }
      else {
        var excepcion = (response.body['message']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );
      }*/
    } else {
      try{
        var excepcion = (response.body['excepcion']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );
      }catch(exception){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.errorRed),backgroundColor: Colors.redAccent,),);
      }
    }
  }

  Future<List<TipoControlProspectoItemOutPutModel>?> consultaTipoControlProspecto(BuildContext context) async {
    //LoadingIndicatorDialog().show(context);
    Response response = await puntoAzulRepo.postConsultaTipoControlProspecto();
    //LoadingIndicatorDialog().dismiss();
    var data  = null;
   // _tipoControlProspectoOutPutModel = null;
    if (response.statusCode == 200) {
      SnackBar(content: Text(AppConstants.guardadoCorrectamente),backgroundColor: Colors.blueAccent);
   //var resultado = jsonDecode(response.body.toString());
      data = response.body;
      _listaTipoControl = [];
      response.body.forEach((category) {
        _listaTipoControl?.add(TipoControlProspectoItemOutPutModel.fromJson(category));
      });
      //_listaTipoControl = TipoControlProspectoItemOutPutModel.fromJson(response.body) as List<TipoControlProspectoItemOutPutModel>?;
     // var data =  response.body;
      //parsePhotos(response.body.toString());
   var a = 0;
        //TipoControlProspectoOutPutModel.fromJson(response.body);
    } else {
      try{
        var excepcion = (response.body['excepcion']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );
      }catch(exception){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.errorRed),backgroundColor: Colors.redAccent,),);
      }
    }
    return await _listaTipoControl!;
  }

  Future<void> activaDesactivaTarjeta(PuntoAzulInputModel puntoAzulInputModel,BuildContext context) async {
    //LoadingIndicatorDialog().show(context);
    Response response = await puntoAzulRepo.postConsultaPuntosAzules(puntoAzulInputModel);
    //LoadingIndicatorDialog().dismiss();

    if (response.statusCode == 200) {
      if(bool.parse(response.body['success'].toString())){
        var mensaje = (response.body['message'].toString());
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(mensaje),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje),backgroundColor: Colors.blueAccent,),
        );*/
      }
      else {
        var excepcion = (response.body['message']);
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(excepcion),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );*/
      }
    } else {
      try{
        var excepcion = (response.body['excepcion']);
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );*/
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(excepcion),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }catch(exception){
        /**ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.errorRed),backgroundColor: Colors.redAccent,),);*/
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Aviso'),
            content:  Text(AppConstants.errorRed),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Aceptar'),
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<PuntoAzulCortesiaOutputModel?> consultaPuntoCortesia(BuildContext context) async {
    //LoadingIndicatorDialog().show(context);
    //_isLoading = true;
   // update();
    Response response = await puntoAzulRepo.postConsultaPuntosCortesia();
   // LoadingIndicatorDialog().dismiss();
    //_isLoading = false;
    if (response.statusCode == 200) {
      _puntoAzulCortesiaOutputModel = PuntoAzulCortesiaOutputModel.fromJson(response.body);
    } else {
      try{
        var excepcion = (response.body['excepcion']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(excepcion),backgroundColor: Colors.redAccent,),
        );
      }catch(exception){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppConstants.errorRed),backgroundColor: Colors.redAccent,),);
      }
    }
    //update();
    return _puntoAzulCortesiaOutputModel;
  }
}