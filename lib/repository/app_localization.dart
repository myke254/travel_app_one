import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello-world': 'Hello world!',
    },
    'fr': {
      'hello-world': 'Bonjour le monde!',
    },
    'es': {
      'hello-world': 'Hola mundo!',
    },
    'ru': {
      'hello-world': 'Здравствуй, мир!',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? '** $key not found';
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'fr', 'es', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<AppLocalization>(
      AppLocalization(locale),
    );
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}