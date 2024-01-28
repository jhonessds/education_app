import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/auth_failure.dart';
import 'package:demo/core/errors/failure.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthController {
  AuthController({
    required SignInWithEmail signInWithEmail,
  }) : _signInWithEmail = signInWithEmail;

  final SignInWithEmail _signInWithEmail;

  Failure failure = const AuthFailure(statusCode: StatusCode.unknown);
  bool isRegistred = true;

  Future<bool> signInWithEmail(String email, String password) async {
    final result = await _signInWithEmail(
      SignInParams(
        email: email,
        password: password,
      ),
    );

    return result.fold(
      (f) {
        failure = f;
        if (f is FirebaseAuthFailure) {
          failure.message = translation().problemWithRequest;
        } else if (f is UserNotFound) {
          isRegistred = false;
        } else {
          failure.message = f.statusCode.translated;
        }
        return false;
      },
      (user) {
        Modular.get<SessionController>().setLoggedUser(user as UserModel);
        return true;
      },
    );
  }
}
