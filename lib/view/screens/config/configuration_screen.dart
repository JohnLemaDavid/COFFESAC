import 'package:efood_table_booking/util/app_constants.dart';
import 'package:efood_table_booking/view/screens/punto_azul/lector_qr_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:efood_table_booking/controller/punto_azul_controller.dart';
import 'package:efood_table_booking/data/model/response/authenticate_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});
  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();

}


class _ConfigurationScreenState extends State<ConfigurationScreen> {
  late final SharedPreferences sharedPreferences ;
  final TextEditingController _valueBaseUrlCoffeeSacSoftBank = new TextEditingController();
  final TextEditingController _valueCoffeeSacAmbiente = new TextEditingController();
  final TextEditingController _valueCoffeeSacGuardaProspecto = new TextEditingController();
  final TextEditingController _valueCoffeeSacAutentica = new TextEditingController();
  final TextEditingController _valueUrlBaseMenuCoffe = new TextEditingController();
  //BuildContext _context = null;
  @override
  void initState()  {

    super.initState();
    () async {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        _valueBaseUrlCoffeeSacSoftBank.text = (sharedPreferences.getString(AppConstants.nombreBaseUrlCoffeeSacSoftBank))!;
        _valueCoffeeSacAmbiente.text = (sharedPreferences.getString(AppConstants.nombreCoffeeSacAmbiente))!;
        _valueCoffeeSacGuardaProspecto.text = (sharedPreferences.getString(AppConstants.nombreCoffeeSacGuardaProspecto))!;
        _valueCoffeeSacAutentica.text = (sharedPreferences.getString(AppConstants.nombreCoffeeSacAutentica))!;
         _valueUrlBaseMenuCoffe.text = (sharedPreferences.getString(AppConstants.nombreBaseUrl))!;
      });
    } ();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppConstants.tituloConfiguracionScreen),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueBaseUrlCoffeeSacSoftBank,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: AppConstants.labelBaseUrlCoffeSac,
                  ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseGenerico;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueCoffeeSacAmbiente,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: AppConstants.labelNombreEmpresa,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseGenerico;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueCoffeeSacGuardaProspecto,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: AppConstants.labelCoffeeSacGuardaProspecto,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseGenerico;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueCoffeeSacAutentica,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: AppConstants.labelCoffeeSacAutentica,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseGenerico;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _valueUrlBaseMenuCoffe,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: AppConstants.labelBaseUrlMenuCoffee,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.ingreseGenerico;
                  }
                  return null;
                },
              ),
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
                    sharedPreferences.setString(AppConstants.nombreBaseUrlCoffeeSacSoftBank, _valueBaseUrlCoffeeSacSoftBank.text.toString());
                    sharedPreferences.setString(AppConstants.nombreCoffeeSacAmbiente, _valueCoffeeSacAmbiente.text.toString());
                    sharedPreferences.setString(AppConstants.nombreCoffeeSacGuardaProspecto, _valueCoffeeSacGuardaProspecto.text.toString());
                    sharedPreferences.setString(AppConstants.nombreCoffeeSacAutentica, _valueCoffeeSacAutentica.text.toString());
                    sharedPreferences.setString(AppConstants.nombreBaseUrl, _valueUrlBaseMenuCoffe.text.toString());
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Actualizado correctamente')),
                        );
                  }
                  /**Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));*/
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Background color
                ),
                child: Text(
                  AppConstants.botonActualizar,
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
    );
  }
}