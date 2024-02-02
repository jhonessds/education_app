import 'dart:io';

import 'package:demo/app/modules/profile/domain/usecases/save_profile_picture.dart';
import 'package:demo/app/modules/profile/domain/usecases/update_user.dart';
import 'package:demo/core/common/actions/user_actions.dart';
import 'package:demo/core/common/models/user_model.dart';

class ProfileController {
  ProfileController({
    required UpdateUser updateUser,
    required SaveProfilePicture saveProfilePicture,
  })  : _updateUser = updateUser,
        _saveProfilePicture = saveProfilePicture;

  final UpdateUser _updateUser;
  final SaveProfilePicture _saveProfilePicture;
  String errorMessage = '';

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
