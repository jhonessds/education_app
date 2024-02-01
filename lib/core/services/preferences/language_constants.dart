import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/models/language_model.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setLocale(LanguageModel language) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', language.locale.languageCode);
  appConfigState.value = appConfigState.value.copyWith(language: language);
}

Future<void> getLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final languageCode = prefs.getString('languageCode');
  final language = languages.firstWhere(
    (l) {
      return l.locale.languageCode == languageCode;
    },
    orElse: () => languages.first,
  );
  appConfigState.value = appConfigState.value.copyWith(language: language);
}

Flag getLocaleFlag(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return Flag(Flags.united_states_of_america, size: 28);
    case 'pt':
      return Flag(Flags.brazil, size: 28);
    case 'es':
      return Flag(Flags.spain, size: 28);
    default:
      return Flag(Flags.united_states_of_america, size: 28);
  }
}

AppLocalizations translation() {
  final context = NavigationService.instance.currentContext;
  return AppLocalizations.of(context)!;
}
