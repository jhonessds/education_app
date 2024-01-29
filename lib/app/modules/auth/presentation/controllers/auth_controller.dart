import 'package:demo/app/modules/auth/domain/usecases/sign_in_anonymously.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_facebook.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_github.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_google.dart';
import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/common/entities/user.dart';
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
    required SignInWithGoogle signInWithGoogle,
    required SignInAnonymously signInAnonymously,
    required SignInWithGithub signInWithGithub,
    required SignInWithFacebook signInWithFacebook,
  })  : _signInWithEmail = signInWithEmail,
        _signInWithGoogle = signInWithGoogle,
        _signInWithGithub = signInWithGithub,
        _signInWithFacebook = signInWithFacebook,
        _signInAnonymously = signInAnonymously;

  final SignInWithEmail _signInWithEmail;
  final SignInWithGoogle _signInWithGoogle;
  final SignInAnonymously _signInAnonymously;
  final SignInWithGithub _signInWithGithub;
  final SignInWithFacebook _signInWithFacebook;

  String email = '';
  String password = '';
  AuthMethodType authType = AuthMethodType.email;

  Failure failure = const AuthFailure(statusCode: StatusCode.unknown);
  bool isRegistred = false;
  String errorMessage = '';

  Future<bool> signInWithGoogle() async {
    final result = await _signInWithGoogle();
    return processResult(result);
  }

  Future<bool> signInWithFacebook() async {
    final result = await _signInWithFacebook();
    return processResult(result);
  }

  Future<bool> signInWithGithub() async {
    final result = await _signInWithGithub();
    return processResult(result);
  }

  Future<bool> signInAnonymously() async {
    final result = await _signInAnonymously();
    return processResult(result);
  }

  Future<bool> signInWithEmail() async {
    final result = await _signInWithEmail(
      SignInParams(
        email: email,
        password: password,
      ),
    );
    return processResult(result);
  }

  Future<bool> processResult(Either<Failure, User> result) async {
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
