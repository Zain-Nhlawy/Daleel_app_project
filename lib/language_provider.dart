import 'package:daleel_app_project/dependencies.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = Locale(language);

  Locale get currentLocale => _currentLocale;

  void changeLanguage(String langCode) {
    _currentLocale = Locale(langCode);
    notifyListeners(); // This triggers the UI update
  }
}