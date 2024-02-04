import 'package:demo/app/modules/auth/domain/usecases/email_has_verified.dart';
import 'package:demo/app/modules/auth/domain/usecases/forgot_password.dart';
import 'package:demo/app/modules/auth/domain/usecases/send_email_verification.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_anonymously.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_facebook.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_github.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_google.dart';
import 'package:demo/app/modules/auth/domain/usecases/update_password.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/actions/user_actions.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/auth_failure.dart';
import 'package:demo/core/errors/failure.dart';
import 'package:demo/core/utils/status_code.dart';

class AuthController {
  AuthController({
    required SignInWithEmail signInWithEmail,
    required SignInWithGoogle signInWithGoogle,
    required SignInWithGithub signInWithGithub,
    required SignInWithFacebook signInWithFacebook,
    required SignInAnonymously signInAnonymously,
    required ForgotPassword forgotPassword,
    required UpdatePassword updatePassword,
    required SendEmailVerification sendEmailVerification,
    required EmailHasVerified emailHasVerified,
  })  : _signInWithEmail = signInWithEmail,
        _signInWithGoogle = signInWithGoogle,
        _signInWithGithub = signInWithGithub,
        _signInWithFacebook = signInWithFacebook,
        _sendEmailVerification = sendEmailVerification,
        _forgotPassword = forgotPassword,
        _emailHasVerified = emailHasVerified,
        _updatePassword = updatePassword,
        _signInAnonymously = signInAnonymously;

  final SignInWithEmail _signInWithEmail;
  final SignInWithGoogle _signInWithGoogle;
  final SignInAnonymously _signInAnonymously;
  final SignInWithGithub _signInWithGithub;
  final SignInWithFacebook _signInWithFacebook;
  final ForgotPassword _forgotPassword;
  final UpdatePassword _updatePassword;
  final SendEmailVerification _sendEmailVerification;
  final EmailHasVerified _emailHasVerified;

  String email = '';
  String password = '';
  String newPassword = '';
  AuthMethodType authMethod = AuthMethodType.email;

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

  Future<bool> signInWithEmail() async {
    final result = await _signInWithEmail(
      SignInParams(
        email: email,
        password: password,
      ),
    );
    return processResult(result);
  }

  Future<bool> signInAnonymously() async {
    final result = await _signInAnonymously();
    return processResult(result);
  }

  Future<bool> forgotPassword({
    required String email,
  }) async {
    final result = await _forgotPassword(email);

    return result.fold(
      (f) {
        errorMessage = f.statusCode.translated;
        return false;
      },
      (_) {
        return true;
      },
    );
  }

  Future<bool> updatePassword() async {
    final result = await _updatePassword(
      UpdatePasswordParams(
        oldPassword: password,
        newPassword: newPassword,
      ),
    );

    return result.fold(
      (f) {
        if (f.statusCode == StatusCode.invalidCredential) {
          errorMessage = translation().previousPasswordInvalid;
        } else {
          errorMessage = f.statusCode.translated;
        }
        return false;
      },
      (_) {
        return true;
      },
    );
  }

  Future<bool> sendEmailVerification() async {
    final result = await _sendEmailVerification();

    return result.fold(
      (f) {
        errorMessage = f.statusCode.translated;
        return false;
      },
      (_) {
        return true;
      },
    );
  }

  Future<bool> emailHasVerified() async {
    final result = await _emailHasVerified();

    return result.fold(
      (f) {
        errorMessage = f.statusCode.translated;
        return false;
      },
      (r) {
        return r;
      },
    );
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
      (user) async {
        await setLoggedUser(user as UserModel);
        return true;
      },
    );
  }
}
