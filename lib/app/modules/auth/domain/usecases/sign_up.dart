import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecaseWithParam<void, SignUpParams> {
  SignUp({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(SignUpParams params) async => repository.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  factory SignUpParams.empty() {
    return const SignUpParams(
      email: '',
      password: '',
      fullName: '',
    );
  }

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object> get props => [email, password];
}
