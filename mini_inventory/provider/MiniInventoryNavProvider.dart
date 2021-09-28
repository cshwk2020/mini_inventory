
import 'package:flutter/material.dart';
import 'package:mini_inventory/mini_inventory/theme/AppNavMode.dart';
import 'package:mini_inventory/mini_inventory/theme/AppThemeMode.dart';
import 'package:mini_inventory/mini_inventory/theme/ThemeModeManager.dart';
import 'package:mini_inventory/mini_inventory/theme/MiniInventoryTheme.dart';

class AppNavProvider extends ChangeNotifier {

  int _selectedIndex = 0;

  bool isNavMode_counter() {
    return _selectedIndex == 0;
  }

  bool isNavMode_counterCat() {
    return _selectedIndex == 1;
  }

  bool isNavMode_reporting() {
    return _selectedIndex == 2;
  }

  bool isNavMode_setting() {
    return _selectedIndex == 3;
  }

  void setSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  int getSelectedIndex() {
    return _selectedIndex;
  }
}

