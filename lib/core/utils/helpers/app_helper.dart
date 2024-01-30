import 'package:shared_preferences/shared_preferences.dart';

class AppHelper {
  static Future<bool> setNavOption({required int option}) async {
    await removeNavOption();
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setInt('navOption', option);
    return result;
  }

  static Future<bool> removeNavOption() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('navOption');
    return result;
  }

  static Future<int> getNavOption() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getInt('navOption');
    return result ?? 0;
  }
}
