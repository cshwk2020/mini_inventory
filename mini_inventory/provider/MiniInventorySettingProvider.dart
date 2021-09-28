
import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/model/CounterLayoutMode.dart';
import 'package:mini_inventory/mini_inventory/theme/AppThemeMode.dart';
import 'package:mini_inventory/mini_inventory/theme/ThemeModeManager.dart';
import 'package:mini_inventory/mini_inventory/theme/MiniInventoryTheme.dart';

class SettingProvider extends ChangeNotifier {

  int get_MIN_COUNTER_VALUE() {
    return 0;
  }

  int get_MAX_COUNTER_VALUE() {
    return 999999;
  }

  //
  String _counterLayoutMode = CounterLayoutMode.Layout_Plus_Minus;

  void setCounterLayoutMode(String counterLayoutMode) {
    _counterLayoutMode = counterLayoutMode;
    notifyListeners();
  }

  String getCounterLayoutMode() {
    return _counterLayoutMode;
  }



  //
  bool _isEditCounterCatMode = false;

  void toggleEditCounterCatMode() {
    _isEditCounterCatMode = !_isEditCounterCatMode;
    notifyListeners();
  }

  bool getEditCounterCatMode() {
    return _isEditCounterCatMode;
  }


  //
  bool _isEditCounterMode = false;

  void toggleEditCounterMode() {
    _isEditCounterMode = !_isEditCounterMode;
    notifyListeners();
  }

  bool getEditCounterMode() {
    return _isEditCounterMode;
  }


  //
  IThemeModeManager themeModeManager = ThemeModeManager();

  bool isDarkThemeMode() {
    bool result = (themeModeManager.getAppThemeMode() == AppThemeMode.dark);
    //print("isDarkThemeMode == ${result}");
    return result;
  }

  ThemeData getAppThemeData() {
    return  isDarkThemeMode() ? MiniInventoryTheme.dark() : MiniInventoryTheme.light();
  }

  void setAppThemeMode(bool isDarkMode) {
    //print("setAppThemeMode == ${isDarkMode}");
    themeModeManager.setAppThemeMode( isDarkMode ? AppThemeMode.dark : AppThemeMode.light);
    notifyListeners();
  }
}