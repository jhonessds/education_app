import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  static SessionController sessionCtrl = Modular.get<SessionController>();
  static String name() {
    return sessionCtrl.hasCurrentUser ? sessionCtrl.currentUser.name : '';
  }

  static bool pushNotification() {
    return sessionCtrl.hasCurrentUser &&
        sessionCtrl.currentUser.fcmToken != null;
  }

  static GenderType gender() {
    return sessionCtrl.hasCurrentUser
        ? sessionCtrl.currentUser.gender
        : GenderType.male;
  }

  static AuthMethodType authMethod() {
    return sessionCtrl.hasCurrentUser
        ? sessionCtrl.currentUser.authMethod
        : AuthMethodType.anonymous;
  }

  static String? profilePicture() {
    return sessionCtrl.hasCurrentUser
        ? sessionCtrl.currentUser.profilePicture
        : null;
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
