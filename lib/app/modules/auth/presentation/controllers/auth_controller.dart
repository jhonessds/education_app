import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
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

  String email = '';
  String password = '';
  AuthMethodType authType = AuthMethodType.email;

  Failure failure = const AuthFailure(statusCode: StatusCode.unknown);
  bool isRegistred = true;
  String errorMessage = '';

  Future<bool> signInWithEmail() async {
    final result = await _signInWithEmail(
      SignInParams(
        email: email,
        password: password,
      ),
    );

    return result.fold(
      (f) {
        failure = f;
        if (f.statusCode == StatusCode.firebaseAuthFailure) {
          isRegistred = true;
          errorMessage = translation().problemWithRequest;
        } else if (f.statusCode == StatusCode.userNotFound) {
          isRegistred = false;
        } else {
          isRegistred = true;
          errorMessage = f.statusCode.translated;
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
