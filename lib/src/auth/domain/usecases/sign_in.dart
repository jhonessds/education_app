import 'package:education_app/core/usecases/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UsecaseWithParam<LocalUser, SignInParams> {
  SignIn({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<LocalUser> call(SignInParams params) async => repository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  factory SignInParams.empty() {
    return const SignInParams(
      email: '',
      password: '',
    );
  }

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
