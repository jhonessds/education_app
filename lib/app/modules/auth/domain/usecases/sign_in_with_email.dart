import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class SignInWithEmail extends UsecaseWithParam<User, SignInParams> {
  SignInWithEmail({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<User> call(SignInParams params) async =>
      repository.signInWithEmail(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
