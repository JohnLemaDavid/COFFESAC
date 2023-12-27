import 'package:efood_table_booking/data/model/response/language_model.dart';
import 'package:efood_table_booking/util/images.dart';

class AppConstants {
  static const String appName = 'CoffeeSac Table';
  static const String appVersion = '1.4';

  // demo
  static const String baseUrlPuntoAzul = 'https://vmovil.coopsac.fin.ec';//'https://vmovil.coopsac.fin.ec'; http://192.168.1.13:8076;
  static const String puntoAzulAmbiente = '/testing';

  static const String baseUrlCoffeeSacSoftBank ='https://vmovil.coopsac.fin.ec/apigateway'; //'https://vmovil.coopsac.fin.ec/apigateway';//'http://192.168.1.13:8076';
  static const String coffeeSacAmbiente = '/api/coffeesac';
  static const String coffeeSacGuardaProspecto = '/prospectosCoffee/save-prospect';
  static const String coffeeSacAutentica = '/usuarioCoffee/authenticate';
  static const String coffeeSacConsultaTipoControlProspecto = '/tipoControlProspecto/tipo-control-item';


  static const String nombreBaseUrlCoffeeSacSoftBank = 'nombreBaseUrlCoffeeSacSoftBank';
  static const String nombreCoffeeSacAmbiente = 'nombreCoffeeSacAmbiente';
  static const String nombreCoffeeSacGuardaProspecto = 'nombreCoffeeSacGuardaProspecto';
  static const String nombreCoffeeSacAutentica = 'nombreCoffeeSacAutentica';
  static const String nombreCoffeeSacConsultaTipoControlProspecto = 'nombreCoffeeSacConsultaTipoControlProspecto';

  static const String authenticatePuntoAzul = '/authenticate';
  static const String empresa = '/coffeesac';
  static const String consultaPuntoAzulUri = '/tarjeta/process';

  static const String consultaPuntoCortesiaUri = '/usuarioParametrosCortesia/courtesy-balance';

  static const String baseUrl = 'https://vmovil.coopsac.fin.ec/apigateway';//'https://vmovil.coopsac.fin.ec/apigateway';//'http://192.168.1.13:80';
  static const String configUri = '/api/v1/config/table';
  static const String categoryUri = '/api/v1/categories';
  static const String productUri = '/api/v1/products/latest';
  static const String categoryProductUri = '/api/v1/categories/products';
  static const String placeOrderUri = '/api/v1/table/order/place';
  static const String orderDetailsUri = '/api/v1/table/order/details?';
  static const String orderList = '/api/v1/table/order/list?branch_table_token=';

  static const String nombreBaseUrl = 'baseUrl';
  static const String nombreBaseUrlPuntoAzul = 'baseUrlPuntoAzul';
  static const String nombrePuntoAzulAmbiente = 'puntoAzulAmbiente';
  static const String nombreEmpresa = 'empresa';

  static const String labelBaseUrlCoffeSac = 'Base Url Coffee Sac';
  static const String labelPuntoAzulAmbiente = 'Ambiente Punto Azul';
  static const String labelCoffeeSacGuardaProspecto = 'Url prospecto';
  static const String labelCoffeeSacAutentica = 'Url Autenticación';

  static const String labelNombreEmpresa = 'Empresa Punto Azul';
  static const String labelBaseUrlMenuCoffee = 'Base Url Menú Coffee SAC';
  static const String escaneaTarjetaCoffeSac = 'Por favor escanea una tarjeta Coffee Sac';
  static const String ingresaCantidadPuntosAzules =  'Por favor ingrese la cantidad de puntos azules';
  static const String guardadoCorrectamente =  'Guardado correctamente';
  static const String fechaDefault = '2023-09-02T00:00:00';
  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String cartList = 'cart_list';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userNumber = 'user_number';
  static const String searchAddress = 'search_address';
  static const String topic = 'notify';
  static const String tableNumber = 'table_number';
  static const String branch = 'branch';
  static const String orderInfo = 'order_info';
  static const String isFixTable = 'is_fix_table';
  static const String tituloInicioSesionScreen = 'Inicio de Sesión';
  static const String tituloConfiguracionScreen = 'Configuración';
  static const String tituloFormularioRegistraPersona = 'Formulario Registro Persona';
  static const String usuario = 'Usuario';
  static const String clave = 'Clave';
  static const String ingreseUsuario = 'Por favor ingrese el usuario';
  static const String ingreseGenerico = 'Por favor ingrese un valor';
  static const String ingreseClave = 'Por favor ingrese la clave';
  static const String ingresar = 'Ingresar';
  static const String procesando = 'Procesando...';
  static const String errorRed = 'Por favor verifique su conexión a Internet';
  static const String tokenPuntoAzul = 'tokenPuntoAzul';
  static const String codigoUsuarioLogin = 'codigoUsuarioLogin';
  static const String consultaPuntosAzules = 'Consulta Puntos Azules';
  static const String signoPuntoAzul = 'Ptos ';
  static const String escaneaUnCodigo = 'Escanea un código QR';
  static const String botonConsulta = 'CONSULTAR';
  static const String botonGuardar = 'GUARDAR';
  static const String botonAcreditar = 'RECARGAR';
  static const String botonDebitar = 'DEBITAR POR USO DE SALA';
  static const String botonActivar = 'ACTIVAR TARJETA';
  static const String botonDesactivar = 'SUSPENDER TARJETA';
  static const String botonActualizar = 'ACTUALIZAR';
  static const String gestionarPuntosAzules = 'Revisa tus Puntos Azules';
  static const String ingresePuntosAzules = 'Ingrese los puntos azules';
  static const String codigoProcesoConsulta = 'CO';
  static const String codigoProcesoCredito = 'CR';
  static const String codigoProcesoDebito = 'DE';
  static const String codigoProcesoActivar = 'RG';
  static const String codigoProcesoSuspender = 'SP';
  static const String codigoProcesoDebitarCoworking = 'CW';
  static const String observacionDebitoSalaCoworking = 'Débito por uso de sala coworking';
  static const String codigoFormaRecarga = 'RPI';
  static const String mensajeConsultaCorrecta = 'Consultado correctamente!';
  static const String cedula_persona = "Cédula";
  static const String nombre_persona = "Nombre";
  static const String celular_persona = "Celular";
  static const String observacion = "Observación";
  static const String ingreseCedula = "Ingrese la cédula";
  static const String ingreseNombre = "Ingrese el nombre";
  static const String ingreseCelular = "Ingrese el celular";
  static const String sinPuntosCortesia = "No dispone de puntos de Cortesía por favor realice una recarga";
  static const String sinPuntosConsumo = "No dispone de puntos por favor realice una recarga";
  static const String insuficientesPuntosCortesia = "No dispone de suficientes puntos de Cortesía por favor realice una recarga";
  static const String insuficientesPuntosConsumo = "No dispone de suficientes puntos por favor realice una recarga";
  static const String verificarPuntosCortesia = "Por favor verifique sus puntos de cortesía";
  static const String necesario = "Necesario";
  static const String disponible = "Disponible";
  static const String puntos = "puntos";
  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.unitedKingdom, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.unitedKingdom, languageName: 'Bengali', countryCode: 'BD', languageCode: 'bn'),
    LanguageModel(imageUrl: Images.saudi, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(imageUrl: Images.spain, languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
  ];
}
