
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:efood_table_booking/controller/punto_azul_controller.dart';
import 'package:efood_table_booking/util/app_constants.dart';
import '../../../data/model/response/authenticate_model.dart';
import '../../../data/model/response/tipo_control_item_model.dart';
import '../config/configuration_screen.dart';
import '../splash/splash_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();

}
class _LoginScreenState extends State<LoginScreen> {
  var puntoAzulController;
  late List<TipoControlProspectoItemOutPutModel> _chefDishes;
  late final SharedPreferences prefs ;
  final TextEditingController _valueUsuario = new TextEditingController();
  final TextEditingController _valueClave = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState()  {
    puntoAzulController = Get.put(PuntoAzulController);
    _valueUsuario.text = "";
    _valueClave.text = "";
    super.initState();
    () async {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        var nombreBaseUrlCoffeeSacSoftBank = (prefs.getString(AppConstants.nombreBaseUrlCoffeeSacSoftBank));
        var nombreCoffeeSacAmbiente = (prefs.getString(AppConstants.nombreCoffeeSacAmbiente));
        var nombreCoffeeSacGuardaProspecto = (prefs.getString(AppConstants.nombreCoffeeSacGuardaProspecto));
        var nombreCoffeeSacAutentica = (prefs.getString(AppConstants.nombreCoffeeSacAutentica));
        var nombreCoffeeSacConsultaTipoControlProspecto = (prefs.getString(AppConstants.nombreCoffeeSacConsultaTipoControlProspecto));
        var baseUrlMenu = (prefs.getString(AppConstants.nombreBaseUrl));
        var tokenPuntoAzul = (prefs.getString(AppConstants.tokenPuntoAzul));
        if(nombreBaseUrlCoffeeSacSoftBank==null)
          prefs.setString(AppConstants.nombreBaseUrlCoffeeSacSoftBank, AppConstants.baseUrlCoffeeSacSoftBank);
        if(nombreCoffeeSacAmbiente == null)
          prefs.setString(AppConstants.nombreCoffeeSacAmbiente, AppConstants.coffeeSacAmbiente);
        if(nombreCoffeeSacGuardaProspecto == null)
          prefs.setString(AppConstants.nombreCoffeeSacGuardaProspecto, AppConstants.coffeeSacGuardaProspecto);
        if(nombreCoffeeSacAutentica == null)
          prefs.setString(AppConstants.nombreCoffeeSacAutentica, AppConstants.coffeeSacAutentica);
        if(nombreCoffeeSacConsultaTipoControlProspecto == null)
          prefs.setString(AppConstants.nombreCoffeeSacConsultaTipoControlProspecto, AppConstants.coffeeSacConsultaTipoControlProspecto);
        if(baseUrlMenu == null)
          prefs.setString(AppConstants.nombreBaseUrl, AppConstants.baseUrl);
        if(tokenPuntoAzul!=null)
        {
          if(tokenPuntoAzul.length>0)
            Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
        }
        prefs.setString(AppConstants.languageCode, AppConstants.languages[3].countryCode!);
        prefs.setString(AppConstants.countryCode, AppConstants.languages[3].languageCode!);
      });
    } ();
  }

@override
Widget build(BuildContext context) {
  var contador = 0;
  Future<void> iniciaSesion() async {
    var credenciales = AuthenticateInputModel(Usuario: _valueUsuario.value.text,Clave: _valueClave.value.text,Maquina: "",IMEI: "");
    var resultado = Get.find<PuntoAzulController>().authenticate(credenciales,context);
    /**_chefDishes =  (await Get.find<PuntoAzulController>().consultaTipoControlProspecto(context))!;
    String sTipos = "";
    for (final item in _chefDishes) {
      sTipos+=item.codigo.toString()+";"+item.nombre.toString()+"?";
    }
    prefs.setString("tipo_control", sTipos);*/

  }
  return Scaffold(
    backgroundColor: Color(0xffffffff),
    body: Form(
      key: _formKey,
      child:Align(
        alignment:Alignment.center,
        child:Padding(
          padding:EdgeInsets.symmetric(vertical: 0,horizontal:16),
          child:SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisSize:MainAxisSize.max,
              children: [
                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
                  image:AssetImage('assets/image/splash_image.png'),
                  height:125,
                  width:185,
                  fit:BoxFit.cover,
                ),
                Padding(
                  padding:EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child:Text(
                    "",
                    textAlign: TextAlign.start,
                    overflow:TextOverflow.clip,
                    style:TextStyle(
                      fontWeight:FontWeight.w700,
                      fontStyle:FontStyle.normal,
                      fontSize:20,
                      color:Color(0xff3a57e8),
                    ),
                  ),
                ),
                Align(
                  alignment:Alignment.centerLeft,
                  child:Text(
                    "Iniciar Sesión",
                    textAlign: TextAlign.start,
                    overflow:TextOverflow.clip,
                    style:TextStyle(
                      fontWeight:FontWeight.w700,
                      fontStyle:FontStyle.normal,
                      fontSize:24,
                      color:Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.symmetric(vertical: 16,horizontal:0),
                  child:TextFormField(
                    controller:_valueUsuario,
                    obscureText:false,
                    textAlign:TextAlign.start,
                    maxLines:1,
                    style:TextStyle(
                      fontWeight:FontWeight.w400,
                      fontStyle:FontStyle.normal,
                      fontSize:16,
                      color:Color(0xff000000),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.ingreseUsuario;
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if(contador==3){
                        /**ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('enter')),
                        );*/
                        contador = 0;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigurationScreen()));
                      }
                      contador++;
                    },
                    decoration:InputDecoration(
                      disabledBorder:OutlineInputBorder(
                        borderRadius:BorderRadius.circular(4.0),
                        borderSide:BorderSide(
                            color:Color(0xff9e9e9e),
                            width:1
                        ),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderRadius:BorderRadius.circular(4.0),
                        borderSide:BorderSide(
                            color:Color(0xff9e9e9e),
                            width:1
                        ),
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderRadius:BorderRadius.circular(4.0),
                        borderSide:BorderSide(
                            color:Color(0xff9e9e9e),
                            width:1
                        ),
                      ),
                      labelText:"Usuario",
                      labelStyle:TextStyle(
                        fontWeight:FontWeight.w400,
                        fontStyle:FontStyle.normal,
                        fontSize:16,
                        color:Color(0xff9e9e9e),
                      ),
                      filled:true,
                      fillColor:Color(0x00f2f2f3),
                      isDense:false,
                      contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                    ),
                  ),
                ),
                TextField(
                  controller:_valueClave,
                  obscureText:true,
                  textAlign:TextAlign.start,
                  maxLines:1,
                  style:TextStyle(
                    fontWeight:FontWeight.w400,
                    fontStyle:FontStyle.normal,
                    fontSize:16,
                    color:Color(0xff000000),
                  ),
                  decoration:InputDecoration(
                    disabledBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(4.0),
                      borderSide:BorderSide(
                          color:Color(0xff9e9e9e),
                          width:1
                      ),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(4.0),
                      borderSide:BorderSide(
                          color:Color(0xff9e9e9e),
                          width:1
                      ),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(4.0),
                      borderSide:BorderSide(
                          color:Color(0xff9e9e9e),
                          width:1
                      ),
                    ),
                    labelText:"Clave",
                    labelStyle:TextStyle(
                      fontWeight:FontWeight.w400,
                      fontStyle:FontStyle.normal,
                      fontSize:16,
                      color:Color(0xff9e9e9e),
                    ),
                    filled:true,
                    fillColor:Color(0x00f2f2f3),
                    isDense:false,
                    contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.fromLTRB(0, 30, 0, 16),
                  child:Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisSize:MainAxisSize.max,
                    children:[
                      SizedBox(
                        width:16,
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed:(){
                            if (_formKey.currentState!.validate()) {
                              iniciaSesion();
                            }

                          },
                          color:Color(0xffec8237),
                          highlightColor :Color(0xfff09b5f),
                          elevation:0,
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(12.0),
                          ),
                          padding:EdgeInsets.all(16),
                          child:Text("Ingresar", style: TextStyle( fontSize:16,
                            fontWeight:FontWeight.w400,
                            fontStyle:FontStyle.normal,
                          ),),
                          textColor:Color(0xffffffff),
                          height:40,
                          minWidth:140,
                        ),
                      ),
                    ],),),
              ],),),),
      )
    ),
  )
  ;}
}