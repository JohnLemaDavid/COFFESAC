import 'package:efood_table_booking/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:efood_table_booking/controller/punto_azul_controller.dart';
import 'package:efood_table_booking/data/model/response/punto_azul_model.dart';
import 'package:efood_table_booking/util/varios.dart';

import '../../base/custom_loader.dart';
class DetalleTarjetaScreen extends StatefulWidget {
  String url;
  DetalleTarjetaScreen({required this.url});
  @override
  _DetalleTarjetaState createState() {
    return _DetalleTarjetaState();
  }
}
class _DetalleTarjetaState extends State<DetalleTarjetaScreen> {
  final TextEditingController _controllerUrl = new TextEditingController();
  String url = '';
  String codigoTarjeta = "";
  String cedulaSocio = "";
  int? contador = 0;
  @override
  void initState() {
    super.initState();
    final puntoAzulController = Get.find<PuntoAzulController>();
    puntoAzulController.isLoadingUpdate = false;
    setState(() {
      url = widget.url;
      var auxArray = GetArrayFromString(widget.url);
      if(auxArray!=null){
        codigoTarjeta = auxArray[2];
        cedulaSocio = auxArray[1];
      }
      else  SnackBar(content: Text(AppConstants.escaneaTarjetaCoffeSac),backgroundColor: Colors.redAccent);
    });
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.gestionarPuntosAzules),
        backgroundColor: Colors.blueAccent,
      ),
      body:  Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child:TextFormField(
                controller: _controllerUrl,
                readOnly: false,
                decoration: InputDecoration(
                  hintText: AppConstants.ingresePuntosAzules,
                  labelStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )

                ),
                style: TextStyle(
                  height: 2.5,
                  textBaseline: TextBaseline.ideographic,
                  fontSize: 30
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingresaCantidadPuntosAzules;
                  }
                  return null;
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {

                       consultaPuntosAzules();
                       contador=(contador!+1)!;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, // Background color
                    ),
                    child: const Text(AppConstants.botonConsulta,
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debitoPuntosAzules(AppConstants.codigoProcesoDebitarCoworking,AppConstants.observacionDebitoSalaCoworking);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                    ),
                    child: const Text(AppConstants.botonDebitar,
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                        activaDesactivaTarjeta(AppConstants.codigoProcesoActivar);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Background color
                    ),
                    child: const Text(AppConstants.botonActivar,
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                        activaDesactivaTarjeta(AppConstants.codigoProcesoSuspender);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent, // Background color
                    ),
                    child: const Text(AppConstants.botonDesactivar,
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void consultaPuntosAzules() async {
    var puntoAzulInputModel = PuntoAzulInputModel(Proceso: AppConstants.codigoProcesoConsulta, Codigo: codigoTarjeta,Identificacion: cedulaSocio);
    Future<String> resultado = Get.find<PuntoAzulController>().consultaPuntoAzul(puntoAzulInputModel,context,true);
    String sResultado = await resultado;
    _controllerUrl.text = sResultado!;
  }
  void debitoPuntosAzules(String proceso,String observacion) async {
    var puntoAzulInputModel = PuntoAzulProcesoInputModel(Proceso: proceso, Codigo: codigoTarjeta,Identificacion: cedulaSocio,Observacion: observacion,
        Valor: double.parse(_controllerUrl.text),
    EstadoTarjeta: "A",EsTarjetaCortesia: false);
     Get.find<PuntoAzulController>().creditoPuntoAzul(puntoAzulInputModel,context);
  }
  void activaDesactivaTarjeta(String proceso) async {
    var puntoAzulInputModel = PuntoAzulInputModel(Proceso: proceso, Codigo: codigoTarjeta,Identificacion: cedulaSocio);
    Get.find<PuntoAzulController>().activaDesactivaTarjeta(puntoAzulInputModel,context);
  }
}
