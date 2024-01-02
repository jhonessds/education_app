import 'dart:io';

import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/src/auth/domain/entities/local_user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> forgotPassword({required String email});

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> updatePassword({
    required String oldPassword,
    required String newPassword,
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

  ResultFuture<String> saveProfilePicture({required File profilePicture});
}
