
import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterLayoutMode.dart';
import 'package:mini_inventory/mini_inventory/theme/AppThemeMode.dart';
import 'package:mini_inventory/mini_inventory/theme/ThemeModeManager.dart';
import 'package:mini_inventory/mini_inventory/theme/MiniInventoryTheme.dart';

class LocalCounterInputProvider extends ChangeNotifier {

  bool _isInputDigitMode = false;

  bool getInputDigitMode() {
    return _isInputDigitMode;
  }

  void setInputDigitMode(bool isInputDigitMode) {
    this._isInputDigitMode = isInputDigitMode;
    notifyListeners();
  }
}