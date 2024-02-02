import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/models/language_model.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/utils/fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setFlexScheme(String flexSchemeName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('flexScheme', flexSchemeName);

  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(flexScheme: flexScheme);
}

Future<void> getFlexScheme() async {
  final prefs = await SharedPreferences.getInstance();
  final flexSchemeName = prefs.getString('flexScheme');

  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(flexScheme: flexScheme);
}

Future<void> setDarkFlexScheme(String flexSchemeName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('darkFlexScheme', flexSchemeName);
  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(
    darkFlexScheme: flexScheme,
  );
}

Future<void> getDarkFlexScheme() async {
  final prefs = await SharedPreferences.getInstance();
  final flexSchemeName = prefs.getString('darkFlexScheme');
  final flexScheme = FlexScheme.values.firstWhere(
    (element) {
      return element.name == flexSchemeName;
    },
    orElse: () => FlexScheme.brandBlue,
  );

  appConfigState.value = appConfigState.value.copyWith(
    darkFlexScheme: flexScheme,
  );
}

Future<void> setFont(String font) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('font', font);
  appConfigState.value = appConfigState.value.copyWith(font: font);
}

Future<void> getFont() async {
  final prefs = await SharedPreferences.getInstance();
  final font = prefs.getString('font') ?? Fonts.poppins;
  appConfigState.value = appConfigState.value.copyWith(font: font);
}

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

Future<void> setTheme(ThemeMode themMode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkMode', themMode == ThemeMode.dark);
  appConfigState.value = appConfigState.value.copyWith(themeMode: themMode);
}

Future<void> getTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  appConfigState.value = appConfigState.value.copyWith(
    themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
  );
}

Future<void> initApp() async {
  await getLocale();
  await getTheme();
  await getFlexScheme();
  await getFont();
  await getDarkFlexScheme();
}

AppLocalizations translation() {
  final context = NavigationService.instance.currentContext;
  return AppLocalizations.of(context)!;
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
