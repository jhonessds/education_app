import 'package:demo/core/errors/failure.dart';
import 'package:demo/core/utils/status_code.dart';

class AuthFailure extends Failure {
  const AuthFailure({required super.statusCode, super.message});
  @override
  List<Object?> get props => [statusCode];
}

class UserNotAuthenticated extends AuthFailure {
  const UserNotAuthenticated({
    super.statusCode = StatusCode.userNotAuthenticated,
    super.message,
  });
}

class UserNotFound extends AuthFailure {
  const UserNotFound({
    super.statusCode = StatusCode.userNotFound,
    super.message,
  });
}

class GoogleAuthFailure extends AuthFailure {
  const GoogleAuthFailure({
    super.statusCode = StatusCode.googleAuthFailure,
    super.message,
  });
}

class FirebaseAuthFailure extends AuthFailure {
  const FirebaseAuthFailure({
    super.statusCode = StatusCode.firebaseAuthFailure,
    super.message,
  });
}

class UserFailure extends AuthFailure {
  const UserFailure({
    required super.statusCode,
    super.message,
  });
}
