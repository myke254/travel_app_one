import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_one/repository/language_helper.dart';

class CurrentData with ChangeNotifier {
   String? currentLanguage;
   Locale locale =const  Locale('en', 'US');

  LanguageHelper languageHelper = LanguageHelper();

  Locale get getlocale => locale;

  void changeLocale(String newLocale) {
    Locale convertedLocale;

    currentLanguage = newLocale;

    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);
    locale = convertedLocale;
    notifyListeners();
  }

  defineCurrentLanguage(context) {
    String definedCurrentLanguage;

    if (currentLanguage != null) {
      definedCurrentLanguage = currentLanguage!;
    } else {
      if (kDebugMode) {
        print(
          "locale from currentData: ${Localizations.localeOf(context).toString()}");
      }
      definedCurrentLanguage = languageHelper
          .convertLocaleToLangName(Localizations.localeOf(context).toString());
    }

    return definedCurrentLanguage;
  }
}