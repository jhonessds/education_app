import 'dart:io';

import 'package:demo/app/modules/profile/data/datasources/profile_datasource.dart';
import 'package:demo/app/modules/profile/domain/repos/profile_repository.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/utils/typedefs.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl(this._datasource);

  final ProfileDataSource _datasource;

  @override
  ResultFuture<bool> deleteUser({required String userId}) async {
    try {
      final result = await _datasource.deleteUser(userId: userId);
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> updateUser({required User user}) async {
    try {
      final result = await _datasource.updateUser(user: user);
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> saveProfilePicture({required File profilePicture}) async {
    try {
      final result = await _datasource.saveProfilePicture(
        profilePicture: profilePicture,
      );
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }
}
