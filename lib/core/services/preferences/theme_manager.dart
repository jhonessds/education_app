import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ThemeMode> setTheme(ThemeMode theme) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkMode', theme == ThemeMode.dark);
  return theme;
}

Future<ThemeMode> getTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  return isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
