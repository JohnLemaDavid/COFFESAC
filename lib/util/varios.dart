import 'package:efood_table_booking/util/styles.dart';
import 'package:flutter/material.dart';
showMessage(BuildContext context,String contentMessage) {
  Widget yesButton = TextButton(
    child: Text("OK",style: TextStyle(color: primary)),
    onPressed:  () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Message"),
    content: Text(contentMessage),
    actions: [
      yesButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

GetArrayFromString(url){
  var arrayAux = url.toString().split(":-)");
  return arrayAux;
}