import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<User?> getSessionUser();
  ResultFuture<void> logOut();
  ResultFuture<void> forgotPassword({required String email});
  ResultFuture<User> signInWithEmail({
    required String email,
    required String password,
  });
  ResultFuture<User> signInWithGoogle();
}
