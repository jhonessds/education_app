import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/profile/domain/usecases/update_user.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileController {
  ProfileController({required UpdateUser updateUser})
      : _updateUser = updateUser;

  final UpdateUser _updateUser;
  String errorMessage = '';

  Future<bool> updateUser({required UserModel user}) async {
    final result = await _updateUser(user);

    return result.fold(
      (f) {
        errorMessage = f.statusCode.translated;
        return false;
      },
      (user) async {
        await Modular.get<SessionController>().setLoggedUser(user as UserModel);
        return true;
      },
    );
  }
}
