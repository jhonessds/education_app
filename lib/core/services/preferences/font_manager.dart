import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/utils/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
