import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  static String name() {
    final user = Modular.get<SessionController>().currentUser;
    return user.name;
  }

  static String? profilePicture() {
    final user = Modular.get<SessionController>().currentUser;
    return user.profilePicture;
  }

  static Future<bool> setUser(UserModel user) async {
    await removeUser();
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('user', user.toJson());
    return result;
  }

  static Future<bool> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('user');
    return result;
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('user');

    if (result != null) {
      return UserModel.fromJson(result);
    }

    return null;
  }
}
