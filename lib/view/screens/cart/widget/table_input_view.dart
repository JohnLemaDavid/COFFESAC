import 'package:efood_table_booking/controller/cart_controller.dart';
import 'package:efood_table_booking/controller/splash_controller.dart';
import 'package:efood_table_booking/data/model/response/config_model.dart';
import 'package:efood_table_booking/helper/responsive_helper.dart';
import 'package:efood_table_booking/util/dimensions.dart';
import 'package:efood_table_booking/util/styles.dart';
import 'package:efood_table_booking/view/base/custom_button.dart';
import 'package:efood_table_booking/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
enum EnumTipoConsumo { cortesia_sac, cortesia_anfitriona,consumo }
class TableInputView extends StatefulWidget {
  const TableInputView({Key? key}) : super(key: key);

  @override
  State<TableInputView> createState() => _TableInputViewState();
}

class _TableInputViewState extends State<TableInputView> {
  final TextEditingController _peopleNumberController = TextEditingController();
  final FocusNode _peopleNumberFocusNode = FocusNode();
  List<String> _errorText = [];


  @override
  void initState() {
    final SplashController splashController = Get.find<SplashController>();
    TableModel? table =  splashController.getTable(splashController.getTableId(), branchId: splashController.getBranchId());
    Get.find<SplashController>().updateTableId(
      Get.find<SplashController>().getTableId() < 0 || table == null
          ? null : Get.find<SplashController>().getTableId(),
      isUpdate: false,
    );
    super.initState();
  }


  @override
  void dispose() {
    _peopleNumberController.dispose();
    _peopleNumberFocusNode .dispose();
    super.dispose();
  }
  EnumTipoConsumo? _tipoConsumo = EnumTipoConsumo.consumo;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (splashController) {
        return GetBuilder<CartController>(
          builder: (cartController) {
            if(cartController.peopleNumber != null && _errorText.isEmpty){
              _peopleNumberController.text = cartController.peopleNumber.toString();
            }
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                  color: Theme.of(context).colorScheme.background,
                ),
                width: 650,
                padding: EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,  children: [

                  SizedBox(height: Dimensions.paddingSizeDefault,),

                  Text('table_number'.tr),
                  SizedBox(height: Dimensions.paddingSizeDefault,),

                  IgnorePointer(
                    ignoring: splashController.getIsFixTable(),
                    child: Container(
                      height: ResponsiveHelper.isSmallTab() ? 40 :  ResponsiveHelper.isTab(context) ? 50 : 40,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),

                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.4))
                        // boxShadow: [BoxShadow(color: Theme.of(context).cardColor, spreadRadius: 2, blurRadius: 5, offset: Offset(0, 5))],
                      ),
                      child: DropdownButton<int>(
                        menuMaxHeight: Get.height * 0.5,

                        hint: Text(
                          'set_your_table_number'.tr,
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                        value: splashController.selectedTableId,

                        items: splashController.configModel?.branch?.firstWhere(
                                (branch) => branch.id == splashController.getBranchId()).table?.map((value) {
                          return DropdownMenuItem<int>(
                            value: value.id,
                            child: Text(
                              '${value.id == -1 ? 'no_table_available'.tr : value.number}',
                              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                            ),
                          );
                        }).toList(),

                        onChanged: (value) {
                          splashController.updateTableId(value == -1 ? null : value, isUpdate: true);
                        },

                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),

                  Row(
                    children: [
                      Text('number_of_people'.tr),
                      SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                      if(splashController.selectedTableId != null)
                        Text(
                          '( ${'max_capacity'.tr} : ${splashController.getTable(splashController.selectedTableId)?.capacity})',
                          style: robotoRegular.copyWith(color: Theme.of(context).hintColor),
                        ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),


                  SizedBox(
                    height: ResponsiveHelper.isSmallTab() ? 40 :  ResponsiveHelper.isTab(context) ? 50 : 40,
                    child: CustomTextField(
                      borderColor: Theme.of(context).hintColor.withOpacity(0.4),
                      controller: _peopleNumberController,
                      inputType: TextInputType.number,
                      inputFormatter:[FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                      hintText: '${'ex'.tr}: 3',
                      hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      focusNode: _peopleNumberFocusNode,
                    ),
                  ),

                  SizedBox(height: Dimensions.paddingSizeDefault,),

                  if(_errorText.isNotEmpty) Text(_errorText.first, style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.error,
                  )),

                  SizedBox(height: Dimensions.paddingSizeDefault,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ), //SizedBox
                      Text(
                        'es_cortesia'.tr
                      ), //Text
                      SizedBox(width: Dimensions.paddingSizeExtraSmall), //SizedBox
                      /** Checkbox Widget **/



                          ListTile(
                            title: Text('consumo'.tr),
                            selected: _tipoConsumo.toString().contains("consumo")?true:false,
                            leading: Radio<EnumTipoConsumo>(
                              value: EnumTipoConsumo.consumo,
                              groupValue: _tipoConsumo,

                              onChanged: (EnumTipoConsumo? value) {
                                setState(() {
                                  _tipoConsumo = value;
                                  //cartController.tipo = value.toString();
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text('cortesiaSac'.tr),
                            selected: _tipoConsumo.toString().contains("cortesia_sac")?true:false,
                            leading: Radio<EnumTipoConsumo>(
                              value: EnumTipoConsumo.cortesia_sac,
                              groupValue: _tipoConsumo,
                              onChanged: (EnumTipoConsumo? value) {
                                setState(() {
                                  _tipoConsumo = value;
                                });
                              },
                            ),
                          ),
                          /**ListTile(
                            title: Text('cortesiaAnfitriona'.tr),
                            leading: Radio<EnumTipoConsumo>(
                              value: EnumTipoConsumo.cortesia_anfitriona,
                              groupValue: _tipoConsumo,
                              onChanged: (EnumTipoConsumo? value) {
                                setState(() {
                                  _tipoConsumo = value;
                                });
                              },
                            ),
                          ),*/
                     //Checkbox
                    ], //<Widget>[]
                  ), //Row

                  SizedBox(height: Dimensions.paddingSizeDefault,),

                  CustomButton(
                    buttonText: 'save'.tr,  width: 300,
                    height: ResponsiveHelper.isSmallTab() ? 40 : 50,
                    onPressed: (){

                      if(splashController.selectedTableId != null && _peopleNumberController.text.isNotEmpty) {
                        // if(Get.find<OrderController>().orderTableNumber != -1 && Get.find<OrderController>().orderTableNumber != splashController.selectedTableId!) {
                        //
                        // }
                        if(splashController.getTable(splashController.selectedTableId)!.capacity! < int.parse(_peopleNumberController.text)) {
                          _errorText = [];
                          _errorText.add('you_reach_max_capacity'.tr);

                        }else{
                          splashController.setTableId(splashController.selectedTableId!);
                          cartController.setPeopleNumber = int.parse(_peopleNumberController.text);
                          cartController.setTipo = _tipoConsumo.toString().split('.').last;
                          cartController.update();
                          Get.back();
                        }


                      }else{

                        _errorText = [];
                        _errorText.add(splashController.selectedTableId == null
                            ? 'set_your_table_number'.tr : 'set_people_number'.tr,
                        );
                      }
                      splashController.update();
                    },
                  ),
                ],),
              ),
            );
          }
        );
      }
    );
  }
}
