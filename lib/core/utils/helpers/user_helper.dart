import 'package:demo/core/common/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  // static String id() {
  //   final user = Modular.get<SessionController>().currentUser;
  //   return user.id;
  // }

  // static UserModel user() {
  //   final user = Modular.get<SessionController>().currentUser;
  //   return user;
  // }

  // static int scopeId() {
  //   final user = Modular.get<SessionController>().currentUser;
  //   return user.scope?.scopeId ?? 0;
  // }

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
