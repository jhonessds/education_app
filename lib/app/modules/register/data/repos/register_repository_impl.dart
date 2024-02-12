import 'package:demo/app/modules/register/data/datasource/register_datasource.dart';
import 'package:demo/app/modules/register/domain/repos/register_repository.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/errors/firebase_failure.dart';
import 'package:demo/core/utils/typedefs.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this._datasource);
  final RegisterDatasource _datasource;

  @override
  ResultFuture<User> registerUser(User user) async {
    try {
      final result = await _datasource.registerUser(user: user);
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }

  @override
  ResultFuture<User> registerUserByEmail({
    required User user,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _datasource.registerUserByEmail(
        user: user,
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseFailure catch (e) {
      return Left(e);
    }
  }
}
