import 'package:demo/core/errors/failure.dart';

class RegisterFailure extends Failure {
  const RegisterFailure({required super.statusCode, super.message});

  @override
  List<Object?> get props => [message, statusCode];
}

class UserAlreadyRegistred extends RegisterFailure {
  const UserAlreadyRegistred({required super.statusCode, super.message});
}
