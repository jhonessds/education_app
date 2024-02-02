import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  static String name() {
    return currentUserState.value.name;
  }

  static bool pushNotification() {
    return currentUserState.value.fcmToken != null;
  }

  static GenderType gender() {
    return currentUserState.value.gender;
  }

  static AuthMethodType authMethod() {
    return currentUserState.value.authMethod;
  }

  static String? profilePicture() {
    return currentUserState.value.profilePicture;
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
