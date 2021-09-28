
import 'package:flutter/cupertino.dart';

import 'AppThemeMode.dart';


abstract class IThemeModeManager {

  AppThemeMode currentThemeMode = AppThemeMode.dark;

  AppThemeMode getAppThemeMode();
  void setAppThemeMode(AppThemeMode _themeMode);

}

class ThemeModeManager extends IThemeModeManager  {

  AppThemeMode getAppThemeMode() {
      return currentThemeMode;
  }

  setAppThemeMode(AppThemeMode _themeMode) {

    currentThemeMode = _themeMode;
  }

}