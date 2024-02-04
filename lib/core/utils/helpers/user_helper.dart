import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/enums/user_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/extensions/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  static String name() {
    if (currentUserState.value.userType == UserType.anonymous) {
      return translation().anonymous.capitalize();
    } else {
      return currentUserState.value.name.capitalize();
    }
  }

  static String firstLetter() {
    if (currentUserState.value.userType == UserType.anonymous) {
      return 'A';
    }
    return currentUserState.value.name[0].capitalize();
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

  static bool isAnonymous() {
    return currentUserState.value.userType == UserType.anonymous;
  }

  static String id() {
    return currentUserState.value.id;
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
