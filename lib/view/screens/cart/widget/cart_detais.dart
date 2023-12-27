import 'package:efood_table_booking/controller/cart_controller.dart';
import 'package:efood_table_booking/controller/order_controller.dart';
import 'package:efood_table_booking/controller/splash_controller.dart';
import 'package:efood_table_booking/data/model/response/cart_model.dart';
import 'package:efood_table_booking/data/model/response/place_order_body.dart';
import 'package:efood_table_booking/data/model/response/product_model.dart';
import 'package:efood_table_booking/helper/date_converter.dart';
import 'package:efood_table_booking/helper/price_converter.dart';
import 'package:efood_table_booking/helper/responsive_helper.dart';
import 'package:efood_table_booking/helper/route_helper.dart';
import 'package:efood_table_booking/util/app_constants.dart';
import 'package:efood_table_booking/util/dimensions.dart';
import 'package:efood_table_booking/util/images.dart';
import 'package:efood_table_booking/util/styles.dart';
import 'package:efood_table_booking/view/base/confirmation_dialog.dart';
import 'package:efood_table_booking/view/base/custom_button.dart';
import 'package:efood_table_booking/view/base/custom_divider.dart';
import 'package:efood_table_booking/view/base/custom_snackbar.dart';
import 'package:efood_table_booking/view/screens/cart/widget/order_note_view.dart';
import 'package:efood_table_booking/view/screens/cart/widget/table_input_view.dart';
import 'package:efood_table_booking/view/screens/home/widget/cart_bottom_sheet.dart';
import 'package:efood_table_booking/view/screens/order/payment_screen.dart';
import 'package:efood_table_booking/view/screens/punto_azul/registro_persona_screen.dart';
import 'package:efood_table_booking/view/screens/root/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../controller/punto_azul_controller.dart';
import '../../../../data/model/response/punto_azul_model.dart';
import '../../../../util/varios.dart';
import '../../punto_azul/lector_qr_note_view.dart';

class CartDetails extends StatelessWidget {
  final bool showButton;

  const CartDetails({
    Key? key, required this.showButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PuntoAzulController);
    /**() async{
      PuntoAzulCortesiaOutputModel? data = await Get.find<PuntoAzulController>().consultaPuntoCortesia(context);
      if(data != null){
        if(data.saldo! > 0){
          if(data.saldo! < ){

          }

        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppConstants.sinPuntosCortesia),backgroundColor: Colors.orangeAccent,),
          );
        }

      }
      int a = 0;
    } ();*/
    return ResponsiveHelper.isTab(context) ? Expanded(
      child: _body(context),
    ) : _body(context);
  }
  Widget _body(BuildContext context){
    // bool _isPortrait = context.height < context.width;
    bool? saldoCortesia;
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeLarge,
        vertical: Dimensions.paddingSizeDefault,
      ),
      child: GetBuilder<SplashController>(builder: (splashController) {
          return GetBuilder<OrderController>(builder: (orderController) {
              return GetBuilder<CartController>(builder: (cartController) {
                DateTime dateTime  = DateTime.now();
                List<List<AddOn>> addOnsList = [];
                List<bool> availableList = [];
                double itemPrice = 0;
                double discount = 0;
                double tax = 0;
                double addOns = 0;
                final orderController =  Get.find<OrderController>();
                bool consumoEsValido = false;
                bool cortesiaEsValido = false;
                bool esValido = false;
                int? idParametroCortesia = 0;
                String? codigoUsuario;
                late final SharedPreferences sharedPreferences;
                //Future<PuntoAzulCortesiaOutputModel?> data =  Get.find<PuntoAzulController>().consultaPuntoCortesia(context);

                List<CartModel> cartList = cartController.cartList;

                for (var cartModel in cartList) {

                  List<AddOn> addOnList = [];
                  cartModel.addOnIds?.forEach((addOnId) {
                    if(cartModel.product != null && cartModel.product?.addOns! != null) {
                      for(AddOn addOns in cartModel.product!.addOns!) {
                        if(addOns.id == addOnId.id) {
                          addOnList.add(addOns);
                          break;
                        }
                      }
                    }
                  });
                  addOnsList.add(addOnList);

                  availableList.add(DateConverter.isAvailable(cartModel.product?.availableTimeStarts, cartModel.product?.availableTimeEnds));

                  for(int index=0; index<addOnList.length; index++) {
                    addOns = addOns + (addOnList[index].price! * cartModel.addOnIds![index].quantity!.toDouble());
                  }
                  itemPrice = itemPrice + (cartModel.price! * cartModel.quantity!);
                  discount = discount + (cartModel.discountAmount! * cartModel.quantity!.toDouble());
                  tax = tax + (cartModel.taxAmount! * cartModel.quantity!.toDouble());
                }
                // double _subTotal = _itemPrice + _tax + _addOns;
                double total = itemPrice - discount + orderController.previousDueAmount() + tax + addOns;
                //String? tipo = "";

                ()  async{
                  sharedPreferences = await SharedPreferences.getInstance();
                } ();
                () async{
                  /**PuntoAzulCortesiaOutputModel? data = await Get.find<PuntoAzulController>().consultaPuntoCortesia(context);
                  if(data != null){

                    if(data.saldo! > 0){

                      if(data.saldo! < total){
                        String? mensaje = AppConstants.insuficientesPuntosCortesia+"\n"+AppConstants.disponible+" "+data.saldo.toString()!+
                            " " + AppConstants.necesario+" "+total.toString()+" "+AppConstants.puntos;
                        /**ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)
                          ,backgroundColor: Colors.redAccent,));*/

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Aviso'),
                            content:  Text(mensaje),
                            actions: <Widget>[
                              /**TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),*/
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Aceptar'),
                                child: const Text('Aceptar'),
                              ),
                            ],
                          ),
                        );
                        saldoCortesia = false;
                      }
                      else  saldoCortesia = true;
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppConstants.sinPuntosCortesia),backgroundColor: Colors.redAccent,),
                      );
                      saldoCortesia = false;
                    }

                  }*/

                } ();

                cartController.setTotalAmount = total;
                return cartList.isEmpty ? NoDataScreen(text: 'please_add_food_to_order'.tr) : Column(
                  children: [

                    Row(children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            splashController.getTable(splashController.getTableId())?.number == null ?
                            Center(
                              child: Text('add_table_number'.tr, style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).secondaryHeaderColor,
                              ),),
                            ) :

                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: '${'table'.tr} ${splashController.getTable(splashController.getTableId())?.number } | ',
                                  style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyLarge!.color,
                                  ),
                                ),

                                TextSpan(text: '${cartController.peopleNumber ?? 'add'.tr} ${'people'.tr}',
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyLarge!.color,
                                  ),
                                ),

                              ],),

                            ),

                          ],
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          //RouteHelper.openDialog(context, const TableInputView(),);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioPersonaScreen()));
                        },

                        child: Image.asset(
                          Images.registraPersona,
                          color: Theme.of(context).secondaryHeaderColor,
                          width: Dimensions.paddingSizeExtraLarge,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          RouteHelper.openDialog(context, const TableInputView(),);
                        },

                        child: Image.asset(
                          Images.editIcon,
                          color: Theme.of(context).secondaryHeaderColor,
                          width: Dimensions.paddingSizeExtraLarge,
                        ),
                      )
                    ],),
                    SizedBox(height: ResponsiveHelper.isSmallTab() ? 20 : 40),


                    Expanded(child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          CartModel cartItem = cartList[index];
                          List<Variation>? variationList;


                          if(cartItem.product!.branchProduct != null && cartItem.product!.branchProduct!.isAvailable!) {
                            variationList = cartItem.product!.branchProduct!.variations;
                          }else{
                            variationList = cartItem.product!.variations;
                          }

                          String variationText = '';
                          String addonsName = '';
                          if(cartItem.variation != null && cartItem.variation!.isNotEmpty ) {

                            cartItem.addOnIds?.forEach((addOn) {
                              addonsName = '$addonsName${addOn.name} (${addOn.quantity}), ';
                            });
                            if(addonsName.isNotEmpty) {
                             addonsName = addonsName.substring(0, addonsName.length -2);
                            }
                          }

                          if(variationList != null && cartItem.variations!.isNotEmpty) {
                            for(int index=0; index<cartItem.variations!.length; index++) {
                              if(cartItem.variations![index].contains(true)) {
                                variationText += '${variationText.isNotEmpty ? ', ' : ''}${cartItem.product!.variations![index].name} (';
                                for(int i=0; i<cartItem.variations![index].length; i++) {

                                  if(cartItem.variations![index][i]) {
                                    variationText += '${variationText.endsWith('(') ? '' : ', '}${variationList[index].variationValues?[i].level} - ${
                                        PriceConverter.convertPrice(variationList[index].variationValues?[i].optionPrice ?? 0)
                                    }';
                                  }
                                }
                                variationText += ')';
                              }
                            }
                          }


                          return InkWell(
                            onTap:() => RouteHelper.openDialog(context, ProductBottomSheet(
                              product: cartItem.product!,
                              cart: cartItem,
                              cartIndex: index,
                            ),
                            ),
                            child: Column(
                              children: [

                                Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Expanded(flex: 5,child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${cartItem.product!.name ?? '' } ${variationText.isNotEmpty ? '($variationText)' : ''}',
                                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.titleLarge!.color!,),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                                      Text(PriceConverter.convertPrice(cartItem.product?.price ?? 0),
                                        style: robotoRegular.copyWith(
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                                     if(addonsName.isNotEmpty) Text('${'addons'.tr}: $addonsName', style: robotoRegular.copyWith(
                                       fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor,
                                     )),


                                    ],
                                  )),

                                  Expanded(child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                    child: Text(
                                      '${cartItem.quantity}', textAlign: TextAlign.center,
                                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.titleLarge!.color!),
                                    ),
                                  )),



                                  Expanded(flex: 2,child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                    child: Text(PriceConverter.convertPrice(
                                       cartItem.price!  * cartItem.quantity!,
                                    ),
                                      textAlign: TextAlign.end, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.titleLarge!.color!),
                                      maxLines: 1,
                                    ),
                                  )),

                                  Expanded(child: IconButton(
                                    onPressed: (){
                                      cartController.removeFromCart(index);
                                      showCustomSnackBar('cart_item_delete_successfully'.tr, isError: false, isToast: true);
                                    },
                                    icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.zero,
                                    iconSize: Dimensions.paddingSizeLarge,
                                  )),
                                ],),
                                SizedBox(height: Dimensions.paddingSizeSmall,),

                                Builder(
                                  builder: (context) {
                                    bool render = false;
                                    render = cartList.isNotEmpty && cartList.length == index + 1;
                                    return !render ?
                                    Column(children: [
                                      CustomDivider(color: Theme.of(context).disabledColor),
                                      SizedBox(height: Dimensions.paddingSizeSmall,),
                                    ],) : ResponsiveHelper.isSmallTab() ? _calculationView(
                                      context, itemPrice,
                                      discount, tax, addOns,
                                      orderController, total,cartController.tipo!
                                    ): const SizedBox();
                                  }
                                ),

                              ],
                            ),
                          );
                        }
                    ),),

                    Column(
                      children: [

                        if(!ResponsiveHelper.isSmallTab() ) _calculationView(
                          context, itemPrice,
                          discount, tax, addOns,
                          orderController, total,cartController.tipo!,
                        ),

                        if(showButton) Row(
                          children: [
                            if(cartController.cartList.isNotEmpty) Expanded(child: CustomButton(
                              height: ResponsiveHelper.isSmallTab() ? 40 : 50,
                              transparent: true,
                              buttonText: 'clear_cart'.tr, onPressed: (){
                              RouteHelper.openDialog(
                                context, ConfirmationDialog(
                                title: '${'clear_cart'.tr} !',
                                icon: Icons.cleaning_services_rounded,
                                description: 'are_you_want_to_clear'.tr,
                                onYesPressed: (){
                                  cartController.clearCartData();
                                  Get.back();
                                },
                                onNoPressed: ()=> Get.back(),
                              ),
                              );

                              //cartController.clearCartData();
                            },)),

                            if(cartController.cartList.isNotEmpty) SizedBox(width: Dimensions.paddingSizeDefault,),

                            Expanded(
                              child: CustomButton(
                                height: ResponsiveHelper.isSmallTab() ? 40 : 50,
                                buttonText: 'place_order'.tr,
                                onPressed: (){


                                  //if(saldoCortesia! && cartController.tipo=="cortesia")
                                   // {
                                      if(splashController.getTableId() == -1) {
                                        showCustomSnackBar('please_input_table_number'.tr);
                                      }else if(cartController.peopleNumber == null) {
                                        showCustomSnackBar('please_enter_people_number'.tr);
                                      }else if(cartController.cartList.isEmpty) {
                                        showCustomSnackBar('please_add_food_to_order'.tr);
                                      }else if(cartController.tipo=="consumo" && orderController.orderNote==null){
                                        //if(orderController.orderNote!.isEmpty){
                                        consumoEsValido = false;
                                        showCustomSnackBar('escanea_tarjeta'.tr);
                                        //}
                                      }
                                      else{

                                        /**if(cartController.tipo=="consumo" && orderController.orderNote!.isEmpty){
                                          consumoEsValido = false;
                                          showCustomSnackBar('escanea_tarjeta'.tr);
                                        }
                                        else {
                                          consumoEsValido = true;
                                        }*/
                                        if(cartController.tipo=="cortesia_sac"){
                                          () async{
                                            PuntoAzulCortesiaOutputModel? data = await Get.find<PuntoAzulController>().consultaPuntoCortesia(context);
                                                if(data != null){
                                                if(data.saldo! > 0){
                                                if(data.saldo! < total){
                                                String? mensaje = AppConstants.insuficientesPuntosCortesia+"\n"+AppConstants.disponible+" "+data.saldo.toString()!+
                                                " " + AppConstants.necesario+" "+total.toString()+" "+AppConstants.puntos;
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
                                                //saldoCortesia = false;
                                                  esValido = false;
                                                }
                                                else  {
                                                  esValido = true;
                                                  idParametroCortesia = data.id;
                                                } //saldoCortesia = true;
                                                }
                                                else {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppConstants.sinPuntosCortesia),backgroundColor: Colors.redAccent,),
                                                );
                                                esValido = false;
                                                //saldoCortesia = false;
                                                }
                                                }
                                          } ();
                                        }

                                       else if(cartController.tipo=="consumo"){
                                         //showCustomSnackBar('consumo');
                                         //esValido = true;
                                         () async{

                                            var auxArray = GetArrayFromString(orderController.orderNote);
                                            if(auxArray!=null){
                                              var codigoTarjeta = auxArray[2];
                                              var cedulaSocio = auxArray[1];
                                              var puntoAzulInputModel = PuntoAzulInputModel(Proceso: AppConstants.codigoProcesoConsulta, Codigo: codigoTarjeta,Identificacion: cedulaSocio);
                                                  Future<String> resultado = Get.find<PuntoAzulController>().consultaPuntoAzul(puntoAzulInputModel,context,false);
                                                  String sResultado = await resultado;
                                                  double? saldo = double.parse(sResultado);

                                              if(resultado != null){
                                                if(saldo! > 0){
                                                  if(saldo! < total){
                                                    String? mensaje = AppConstants.insuficientesPuntosConsumo+"\n"+AppConstants.disponible+" "+saldo.toString()!+
                                                        " " + AppConstants.necesario+" "+total.toString()+" "+AppConstants.puntos;
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
                                                    //saldoCortesia = false;
                                                    esValido = false;
                                                  }
                                                  else  {
                                                    esValido = true;
                                                    //idParametroCortesia = data.id;
                                                  } //saldoCortesia = true;
                                                }
                                                else {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppConstants.sinPuntosConsumo),backgroundColor: Colors.redAccent,),
                                                  );
                                                  esValido = false;
                                                  //saldoCortesia = false;
                                                }
                                              }
                                            }



                                         } ();
                                         /**() async{
                                          var sharedPreferences = await SharedPreferences.getInstance();
                                          codigoUsuario = sharedPreferences.getString(AppConstants.codigoUsuarioLogin);
                                          int a = 0;
                                         } ();*/
                                       }
                                        if(esValido) {
                                          //showCustomSnackBar('listo para procesar: '+cartController.tipo.toString());
                                          List<Cart> carts = [];
                                          for (int index = 0; index < cartController.cartList.length; index++) {
                                            CartModel cart = cartController.cartList[index];
                                            List<int> addOnIdList = [];
                                            List<int> addOnQtyList = [];
                                            List<OrderVariation> variations = [];
                                            cart.addOnIds?.forEach((addOn) {
                                              addOnIdList.add(addOn.id!);
                                              addOnQtyList.add(addOn.quantity!);
                                            });

                                            if(cart.product != null && cart.product!.variations != null && cart.variations != null){
                                              for(int i=0; i<cart.product!.variations!.length; i++) {
                                                if(cart.variations![i].contains(true)) {
                                                  variations.add(OrderVariation(
                                                    name: cart.product!.variations![i].name,
                                                    values: OrderVariationValue(label: []),
                                                  ));
                                                  if(cart.product!.variations![i].variationValues != null) {
                                                    for(int j=0; j < cart.product!.variations![i].variationValues!.length; j++) {
                                                      if(cart.variations![i][j]) {
                                                        variations[variations.length-1].values?.label?.add(cart.product!.variations![i].variationValues?[j].level ?? '');
                                                      }
                                                    }
                                                  }

                                                }
                                              }
                                            }
                                            carts.add(Cart(
                                              cart.product!.id!.toString(), cart.discountedPrice.toString(), '', variations,
                                              cart.discountAmount!, cart.quantity!, cart.taxAmount!, addOnIdList, addOnQtyList,
                                            ));
                                          }


                                          PlaceOrderBody placeOrderBody = PlaceOrderBody(
                                            carts,cartController.tipo,idParametroCortesia,sharedPreferences.getString(AppConstants.codigoUsuarioLogin),sharedPreferences.getString(AppConstants.tokenPuntoAzul), total, Get.find<OrderController>().selectedMethod,
                                            Get.find<OrderController>().orderNote ?? '', 'now', DateFormat('yyyy-MM-dd').format(dateTime),
                                            splashController.getTableId(), cartController.peopleNumber,
                                            '${splashController.getBranchId()}',
                                            '', Get.find<OrderController>().getOrderSuccessModel()?.first.branchTableToken ?? '',
                                          );


                                          Get.find<OrderController>().setPlaceOrderBody = placeOrderBody;

                                          Get.to(
                                            const PaymentScreen(), transition: Transition.leftToRight,
                                            duration: const Duration(milliseconds: 300),
                                          );
                                        }
                                      }
                                    /**}
                                  else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppConstants.verificarPuntosCortesia),backgroundColor: Colors.redAccent,),
                                    );
                                  }*/







                                },),
                            ),



                            // CustomRoundedButton(onTap: (){}, image: Images.edit_icon, widget: Icon(Icons.delete)),
                          ],
                        ),
                      ],
                    ),




                  ],
                );
              }
              );
            }
          );
        }
      ),
    );
  }

  Column _calculationView(
      BuildContext context, double itemPrice, double discount, double tax,
      double addOns, OrderController orderController, double total,String tipo
      ) {
    return Column(
      children: [
        SizedBox(height: Dimensions.paddingSizeDefault,),

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GetBuilder<OrderController>(
              builder: (orderController) {

                return Flexible(
                  child: Text.rich(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(children:  orderController.orderNote != null ? [

                      TextSpan(
                        text: 'note'.tr,
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),

                      TextSpan(text: ' ${orderController.orderNote!}',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),

                    ] : [
                      TextSpan(text: 'add_spacial_note_here'.tr,
                        style: robotoRegular.copyWith(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],),

                  ),
                );
              }
          ),

          InkWell(
            onTap: (){
              RouteHelper.openDialog(context, ScanQrOrderNoteView(
                note: Get.find<OrderController>().orderNote,
                onChange: (note){
                  Get.find<OrderController>().updateOrderNote(
                    note.trim().isEmpty ? null : note,
                  );
                },
              ));
            },
            child: Image.asset(
              Images.qrReader,
              color: Theme.of(context).secondaryHeaderColor,
              width: Dimensions.paddingSizeExtraLarge,
            ),
          ),




        ],),

        SizedBox(height: ResponsiveHelper.isSmallTab()  ? Dimensions.paddingSizeSmall :Dimensions.paddingSizeDefault,),

        CustomDivider(color: Theme.of(context).disabledColor,),
        SizedBox(height: Dimensions.paddingSizeDefault,),

        PriceWithType(type: 'items_price'.tr,amount: PriceConverter.convertPrice(itemPrice),),
        PriceWithType(type:'discount'.tr,amount: '- ${PriceConverter.convertPrice(discount)}'),
        PriceWithType(type: 'vat_tax'.tr, amount :'+ ${PriceConverter.convertPrice(tax)}'),
        PriceWithType(type: 'addons'.tr, amount :'+ ${PriceConverter.convertPrice(addOns)}'),
        PriceWithType(type: 'previous_due'.tr, amount :'+ ${PriceConverter.convertPrice(orderController.previousDueAmount())}'),
        PriceWithType(type:'total'.tr,amount : PriceConverter.convertPrice(total), isTotal: true),
        PriceWithType(type: 'tipo_consumo'.tr,amount: tipo=="consumo"?"consumo":"cortesía"),

        SizedBox(height: Dimensions.paddingSizeDefault,),
      ],
    );
  }





}

class PriceWithType extends StatelessWidget {
  final String type;
  final String amount;
  final bool isTotal;
  const PriceWithType({Key? key, required this.type, required this.amount, this.isTotal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isSmallTab() ? 4 : 8),
      child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(type,  style: isTotal ? robotoBold.copyWith(
          fontSize: Dimensions.fontSizeLarge,
        ) : robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),

        Text(amount, style: isTotal ? robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,
        ) : robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
      ],),
    );
  }
}

