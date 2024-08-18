import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en'; // Default to English

  void setLanguage(String language) {
    currentLanguage = language;
    notifyListeners();
  }
}
