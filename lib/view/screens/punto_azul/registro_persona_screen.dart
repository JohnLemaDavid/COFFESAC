import 'dart:ffi';

import 'package:efood_table_booking/util/app_constants.dart';
import 'package:efood_table_booking/view/screens/punto_azul/lector_qr_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:efood_table_booking/controller/punto_azul_controller.dart';
import 'package:efood_table_booking/data/model/response/authenticate_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../data/model/response/prospecto_model.dart';
import '../../../data/model/response/tipo_control_item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
enum EnumTipoVisita { desea_inversion,desea_credito,recibe_informacion }
class FormularioPersonaScreen extends StatefulWidget {
  const FormularioPersonaScreen({super.key});
  @override
  _FormularioPersonaScreenState createState() => _FormularioPersonaScreenState();

}



class _FormularioPersonaScreenState extends State<FormularioPersonaScreen> {
  late final SharedPreferences sharedPreferences ;
  var puntoAzulController;
  //TipoControlProspectoOutPutModel? lista;
  TipoControlProspectoItemOutPutModel? selectedTipo;
  final TextEditingController _valueCedula = new TextEditingController();
  final TextEditingController _valueNombre = new TextEditingController();
  final TextEditingController _valueCelular = new TextEditingController();
  final TextEditingController _valueObservacion = new TextEditingController();
 //TipoControlProspectoItemOutPutModel? selectedTipo;
  List<TipoControlProspectoItemOutPutModel>? _listaTipo;
  List<Widget>? opciones;
  EnumTipoVisita? enumTipoVisita;
  @override
  void initState()  {
    puntoAzulController = Get.put(PuntoAzulController);
    final puntoAzulController_ = Get.find<PuntoAzulController>();

    //sharedPreferences = await SharedPreferences.getInstance();

    ()  async{
      sharedPreferences = await SharedPreferences.getInstance();
      /**var url = Uri.parse('http://192.168.55.67:7004/api/coffeesac/tipoControlProspecto/tipo-control-item');
      var _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${sharedPreferences.getString(AppConstants.tokenPuntoAzul)}'
      };
      final response = await http.post(url, headers:_mainHeaders);
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<TipoControlProspectoItemOutPutModel> data = jsonResponse.map((data) => TipoControlProspectoItemOutPutModel.fromJson(data)).toList();
        for (TipoControlProspectoItemOutPutModel item in data) {
          opciones!.add(
            RadioListTile(
              value: item!,
              groupValue: selectedTipo,
              title: Text(item.nombre!),
              onChanged: (currentTipo) {
                //print("Current User ${currentUser.firstName}");
                setSelectedTipo(currentTipo as TipoControlProspectoItemOutPutModel);
              },
              selected: selectedTipo == item,
              activeColor: Colors.green,
            ),
          );
        }


      } else {
        throw Exception('Unexpected error occured!');
      }*/
      setState(()   {
      });
    } ();
    super.initState();
  }

  /**() async {

  }();*/
  setSelectedTipo(TipoControlProspectoItemOutPutModel tipo) {
    setState(() {
      selectedTipo = tipo;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //EnumTipoVisita? _tipoVisita = EnumTipoVisita.solo_informacion;
  String? codigoTipoControl;
  @override
  Widget build(BuildContext context) {
    /**String? tipoControl =  sharedPreferences.getString("tipo_control");
    var auxTipo = tipoControl?.split("?");
    for(var name in auxTipo!) {
      var auxiliar = name.split(";");
      _listaTipo?.add(TipoControlProspectoItemOutPutModel(codigo: auxiliar[0], nombre: auxiliar[1]));
      print(name);
    }
    int a = 0;*/
    setSelectedTipo(TipoControlProspectoItemOutPutModel tipo) {
      setState(() {
        selectedTipo = tipo;
      });
    }
    void registraProspecto(){
      var codigo = "";
      if(enumTipoVisita.toString().contains("desea_inversion")){
        codigo = "001";
      }
      else if(enumTipoVisita.toString().contains("desea_credito")) {
        codigo = "002";
      }
      else if(enumTipoVisita.toString().contains("recibe_informacion")){
        codigo = "003";
      }


      var datos = ProspectoInputModel(Identificacion: _valueCedula.value.text,Nombre: _valueNombre.value.text,Telefono: _valueCelular.value.text,FechaSistema: AppConstants.fechaDefault,
          FechaProceso: AppConstants.fechaDefault,CodigoTipoControl:codigo,CodigoUsuario: sharedPreferences.getString(AppConstants.codigoUsuarioLogin));
      Get.find<PuntoAzulController>().guardaDatosProspecto(datos,context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text(AppConstants.tituloFormularioRegistraPersona),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(child:  Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueCedula,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: AppConstants.cedula_persona,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseCedula;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueNombre,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: AppConstants.nombre_persona,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseNombre;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueCelular,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: AppConstants.celular_persona,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseCelular;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: <Widget>[

                  ListTile(
                    title: const Text('DESEA INVERSIÓN'),
                    leading: Radio<EnumTipoVisita>(
                      value: EnumTipoVisita.desea_inversion,
                      groupValue: enumTipoVisita,
                      onChanged: (EnumTipoVisita? value) {
                        setState(() {
                          enumTipoVisita = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('DESEA CRÉDITO'),
                    leading: Radio<EnumTipoVisita>(
                      value: EnumTipoVisita.desea_credito,
                      groupValue: enumTipoVisita,
                      onChanged: (EnumTipoVisita? value) {
                        setState(() {
                          enumTipoVisita = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('RECIBE INFORMACIÓN'),
                    leading: Radio<EnumTipoVisita>(
                      value: EnumTipoVisita.recibe_informacion,
                      groupValue: enumTipoVisita,
                      onChanged: (EnumTipoVisita? value) {
                        setState(() {
                          enumTipoVisita = value;
                        });
                      },
                    ),
                  ),
                ],
              )
              //child: [],//createRadioListUsers()

            ),

            Container(
              height: 70,
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(

                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registraProspecto();
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    /**ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Consulta')),
                        );*/
                  }
                  /**Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));*/
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Background color
                ),
                child: Text(
                  AppConstants.botonGuardar,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),

              ),
            ),
            SizedBox(
              height: 130,
            ),
            ColoredBox(color: Colors.blue)

          ],
        ),
      ),
        )
    );

  }
}