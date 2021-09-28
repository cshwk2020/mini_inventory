

import 'package:flutter/material.dart';

class AppGlobal {
  static void hideKeyboard(BuildContext context) {
    try {
      //FocusManager.instance.primaryFocus.unfocus();
      FocusScope.of(context).unfocus();
    }
    catch (ex) {
      print("hideKeyboard ex: ${ex}");
    }

  }
}