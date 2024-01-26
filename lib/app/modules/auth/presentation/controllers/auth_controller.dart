import 'package:demo/app/modules/auth/domain/usecases/sign_in.dart';
import 'package:demo/core/errors/failure.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  AuthController({
    required this.signIn,
  });

  final SignIn signIn;
  Failure? failure;

  Future<bool> signInWithEmail(String email, String password) async {
    final result = await signIn(SignInParams(email: email, password: password));

    return result.fold(
      (f) {
        failure = failure;
        return false;
      },
      (user) {
        return true;
      },
    );
  }
}
