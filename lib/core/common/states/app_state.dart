import 'package:asp/asp.dart';
import 'package:demo/core/common/models/app_config.dart';
import 'package:demo/core/common/models/language_model.dart';
import 'package:flutter/material.dart';

final appConfigState = Atom<AppConfig>(AppConfig());

List<LanguageModel> languages = <LanguageModel>[
  LanguageModel.english(),
  LanguageModel.portuguese(),
  LanguageModel.spanish(),
];

Locale? localeResolution(Locale? locale, Iterable<Locale> supportedLocales) {
  if (supportedLocales.contains(locale)) {
    return locale;
  }

  return supportedLocales.firstWhere(
    (l) {
      return l.languageCode == locale?.languageCode;
    },
    orElse: () => supportedLocales.first,
  );
}

List<Locale> get supportedLocales => languages.map((e) => e.locale).toList();
