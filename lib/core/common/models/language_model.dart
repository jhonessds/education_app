import 'package:flutter/material.dart';

class LanguageModel {
  const LanguageModel({
    required this.title,
    required this.locale,
  });

  factory LanguageModel.english() {
    return const LanguageModel(
      title: 'English (USA)',
      locale: Locale('en', 'US'),
    );
  }

  factory LanguageModel.portuguese() {
    return const LanguageModel(
      title: 'Português (Brasil)',
      locale: Locale('pt', 'BR'),
    );
  }

  factory LanguageModel.spanish() {
    return const LanguageModel(
      title: 'Español (España)',
      locale: Locale('es', 'ES'),
    );
  }

  final String title;
  final Locale locale;
}
