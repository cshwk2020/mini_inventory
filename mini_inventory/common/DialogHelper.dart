

import 'package:flutter/material.dart';

class DialogHelper {

  static void showOneButtonAlertDialog({
    BuildContext context,
    String title,
    String msg,
    String buttonText,
    Function() onClicked,
}) {

    //
    Widget okButton = TextButton(
      child: Text(buttonText),
      onPressed: () {
        onClicked();
      },
    );

    //
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    //
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}