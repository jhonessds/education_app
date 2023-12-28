import 'package:equatable/equatable.dart';

import 'package:education_app/core/usecases/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repository.dart';

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

  final String email;
  final String password;
  final String fullName;

  factory SignUpParams.empty() {
    return const SignUpParams(
      email: '',
      password: '',
      fullName: '',
    );
  }

  @override
  List<Object> get props => [email, password];
}
