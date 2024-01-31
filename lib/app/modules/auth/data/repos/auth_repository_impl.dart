import 'package:demo/app/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/utils/typedefs.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._datasource);

  final AuthRemoteDataSource _datasource;

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    try {
      await _datasource.forgotPassword(email: email);
      return const Right(null);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User?> getSessionUser() async {
    try {
      final result = await _datasource.getSessionUser();
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> logOut() async {
    try {
      final result = await _datasource.logOut();
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _datasource.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> signInWithGoogle() async {
    try {
      final result = await _datasource.signInWithGoogle();
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> signInAnonymously() async {
    try {
      final result = await _datasource.signInAnonymously();
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> signInWithGithub() async {
    try {
      final result = await _datasource.signInWithGithub();
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> signInWithApple() async {
    try {
      final result = await _datasource.signInWithApple();
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> signInWithFacebook() async {
    try {
      final result = await _datasource.signInWithFacebook();
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final result = await _datasource.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }
}
