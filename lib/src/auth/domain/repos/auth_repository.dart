import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> forgotPassword({required String email});

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  ResultFuture<void> updateUser({
    required LocalUser user,
    required UpdateUserAction action,
  });
}
