import 'package:demo/core/common/models/language_model.dart';
import 'package:demo/core/utils/fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppConfig {
  AppConfig({
    this.font = Fonts.poppins,
    this.themeMode = ThemeMode.system,
    this.flexScheme = FlexScheme.brandBlue,
    this.darkFlexScheme = FlexScheme.brandBlue,
    this.language = const LanguageModel(
      title: 'title',
      locale: Locale('en', 'US'),
    ),
  });

  bool get isDarkMode => themeMode == ThemeMode.dark;

  AppConfig copyWith({
    String? font,
    ThemeMode? themeMode,
    LanguageModel? language,
    FlexScheme? flexScheme,
    FlexScheme? darkFlexScheme,
  }) {
    return AppConfig(
      font: font ?? this.font,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      flexScheme: flexScheme ?? this.flexScheme,
      darkFlexScheme: darkFlexScheme ?? this.darkFlexScheme,
    );
  }

  final String font;
  final ThemeMode themeMode;
  final LanguageModel language;
  final FlexScheme flexScheme;
  final FlexScheme darkFlexScheme;
}
