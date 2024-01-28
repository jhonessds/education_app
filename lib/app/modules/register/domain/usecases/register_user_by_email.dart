import 'package:demo/app/modules/register/domain/repositories/register_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class RegisterUserByEmail extends UsecaseWithParam<User, RegisterParams> {
  RegisterUserByEmail({required this.repository});

  final RegisterRepository repository;

  @override
  ResultFuture<User> call(RegisterParams params) async =>
      repository.registerUserByEmail(
        user: params.user,
        email: params.email,
        password: params.password,
      );
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.user,
    required this.email,
    required this.password,
  });

  final User user;
  final String email;
  final String password;

  @override
  List<Object> get props => [user, email, password];
}
