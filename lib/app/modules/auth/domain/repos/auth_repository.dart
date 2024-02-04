import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<User?> getSessionUser();
  ResultFuture<void> logOut();
  ResultFuture<void> forgotPassword({required String email});
  ResultFuture<void> setLanguageCode({required String languageCode});
  ResultFuture<void> sendEmailVerification();
  ResultFuture<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  });
  ResultFuture<User> signInWithEmail({
    required String email,
    required String password,
  });
  ResultFuture<User> signInWithGoogle();
  ResultFuture<User> signInAnonymously();
  ResultFuture<User> signInWithGithub();
  ResultFuture<User> signInWithFacebook();
  ResultFuture<User> signInWithApple();
  ResultFuture<bool> emailHasVerified();
}
