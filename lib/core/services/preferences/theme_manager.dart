import 'package:demo/core/common/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
