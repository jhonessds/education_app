import 'dart:io';

import 'package:demo/app/modules/profile/domain/usecases/delete_user.dart';
import 'package:demo/app/modules/profile/domain/usecases/save_profile_picture.dart';
import 'package:demo/app/modules/profile/domain/usecases/update_user.dart';
import 'package:demo/core/common/actions/user_actions.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/states/user_state.dart';

class ProfileController {
  ProfileController({
    required UpdateUser updateUser,
    required SaveProfilePicture saveProfilePicture,
    required DeleteUser deleteUser,
  })  : _updateUser = updateUser,
        _deleteUser = deleteUser,
        _saveProfilePicture = saveProfilePicture;

  final UpdateUser _updateUser;
  final SaveProfilePicture _saveProfilePicture;
  final DeleteUser _deleteUser;
  String errorMessage = '';

  String name = '';
  String email = '';
  String bio = '';
  GenderType gender = GenderType.male;

  Future<bool> updateUser({required UserModel user}) async {
    final result = await _updateUser(user);

    return result.fold(
      (f) {
        errorMessage = f.statusCode.translated;
        return false;
      },
      (user) async {
        await setLoggedUser(user as UserModel);
        return true;
      },
    );
  }

  Future<bool> updateEmailVerified({required bool emailVerified}) async {
    final user = currentUserState.value;
    return updateUser(user: user.copyWith(verified: emailVerified));
  }

  Future<bool> updateFcmToken({required String fcmToken}) async {
    final user = currentUserState.value;
    return updateUser(user: user.copyWith(fcmToken: fcmToken));
  }

  Future<bool> deleteUser({required String userId}) async {
    final result = await _deleteUser(userId);

    return result.fold(
      (f) {
        errorMessage = f.statusCode.translated;
        return false;
      },
      (r) async {
        return r;
      },
    );
  }

  Future<bool> saveProfilePicture({required File file}) async {
    final result = await _saveProfilePicture(file);

    return result.fold(
      (f) {
        errorMessage = f.statusCode.translated;
        return false;
      },
      (user) async {
        await setLoggedUser(user as UserModel);
        return true;
      },
    );
  }
}
