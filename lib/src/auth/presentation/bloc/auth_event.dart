part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object> get props => [email, password, fullName];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({required this.email});

  final String email;

  @override
  List<String> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  const UpdateUserEvent({required this.user, required this.action});

  final LocalUser user;
  final UpdateUserAction action;

  @override
  List<Object> get props => [user, action];
}

class UpdatePasswordEvent extends AuthEvent {
  const UpdatePasswordEvent({
    required this.newPassword,
    required this.oldPassword,
  });

  final String newPassword;
  final String oldPassword;

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class SaveProfilePictureEvent extends AuthEvent {
  const SaveProfilePictureEvent({required this.file});

  final File file;

  @override
  List<Object> get props => [file];
}
