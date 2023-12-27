import 'package:flutter/cupertino.dart';
import 'package:efood_table_booking/util/dimensions.dart';
import 'package:efood_table_booking/util/styles.dart';
import 'package:efood_table_booking/view/base/custom_button.dart';
import 'package:efood_table_booking/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
class ScanQrOrderNoteView extends StatefulWidget {
  final String? note;
  final Function(String) onChange;
  const ScanQrOrderNoteView({Key? key, required this.onChange, this.note}) : super(key: key);

  @override
  State<ScanQrOrderNoteView> createState() => _ScanQrOrderNoteViewState();
}


class _ScanQrOrderNoteViewState extends State<ScanQrOrderNoteView> {
  final _noteController = TextEditingController();

  @override
  void initState() {
    if(widget.note != null) {
      _noteController.text = widget.note!;
    }
    super.initState();
  }
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 600,
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge,  horizontal: Dimensions.paddingSizeExtraLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              child: CustomTextField(
                borderColor: Theme.of(context).primaryColor.withOpacity(0.3),
                controller: _noteController,
                maxLines: 5,
                hintText: 'add_spacial_note_here'.tr,
                hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                isEnabled: true,
              ),
            ),
            SizedBox(height: Dimensions.paddingSizeDefault,),
            SizedBox(
                height: 300,
                child: Column(
                children: <Widget>[
                  Expanded(flex: 4, child: _buildQrView(context)),
                ],
            ),


            ),

            CustomButton(
                height: 40, width: 200,
                buttonText: 'save'.tr, onPressed:() {
              widget.onChange(_noteController.text);
              Get.back();
            }
            ),
          ],
        ),

      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _noteController.text = result!.code.toString();
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
