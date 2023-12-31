import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/server_failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._datasource);

  final AuthRemoteDataSource _datasource;

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    try {
      await _datasource.forgotPassword(email: email);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _datasource.signIn(email: email, password: password);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      await _datasource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> updateUser({
    required LocalUser user,
    required UpdateUserAction action,
  }) async {
    try {
      await _datasource.updateUser(user: user, action: action);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _datasource.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<String> saveProfilePicture({
    required File profilePicture,
  }) async {
    try {
      final result = await _datasource.saveProfilePicture(
        profilePicture: profilePicture,
      );
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }
}
