import 'package:daleel_app_project/dependencies.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _currentLocale = Locale(language);
  ThemeMode _currentTheme = (appTheme == "dark" ? ThemeMode.dark : ThemeMode.light);

  Locale get currentLocale => _currentLocale;
  ThemeMode get currentTheme => _currentTheme;

  void changeLanguage(String langCode) {
    _currentLocale = Locale(langCode);
    notifyListeners(); // This triggers the UI update
  }
  
  void changeTheme(ThemeMode themeMode) {
    _currentTheme = themeMode;
    notifyListeners(); // This triggers the UI update
  }
}