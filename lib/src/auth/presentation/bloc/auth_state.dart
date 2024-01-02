part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class SignedIn extends AuthState {
  const SignedIn({required this.user});

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

class SignedUp extends AuthState {
  const SignedUp();
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

class UserUpdated extends AuthState {
  const UserUpdated();
}

class PasswordUpdated extends AuthState {
  const PasswordUpdated();
}

class ProfilePictureSaved extends AuthState {
  const ProfilePictureSaved({required this.urlImage});

  final String urlImage;

  @override
  List<Object> get props => [urlImage];
}
