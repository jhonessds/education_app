import 'package:education_app/src/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String LANGUAGE_CODE = 'languageCode';

//languages code
// ignore: constant_identifier_names
const String ENGLISH = 'en';
// ignore: constant_identifier_names
const String PORTUGUESE = 'pt';
// ignore: constant_identifier_names
const String SPANISH = 'es';

Future<Locale> setLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString(LANGUAGE_CODE) ?? PORTUGUESE;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case PORTUGUESE:
      return const Locale(PORTUGUESE, '');
    case SPANISH:
      return const Locale(SPANISH, '');
    default:
      return const Locale(ENGLISH, '');
  }
}

AppLocalizations translation() {
  final context = NavigationService.instance.currentContext;
  return AppLocalizations.of(context)!;
}
