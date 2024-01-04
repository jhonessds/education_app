import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/utils/status_code.dart';

import 'package:demo/src/auth/domain/entities/local_user.dart';
import 'package:demo/src/auth/domain/usecases/forgot_password.dart';
import 'package:demo/src/auth/domain/usecases/save_profile_picture.dart';
import 'package:demo/src/auth/domain/usecases/sign_in.dart';
import 'package:demo/src/auth/domain/usecases/sign_up.dart';
import 'package:demo/src/auth/domain/usecases/update_password.dart';
import 'package:demo/src/auth/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required UpdateUser updateUser,
    required ForgotPassword forgotPassword,
    required UpdatePassword updatePassword,
    required SaveProfilePicture saveProfilePicture,
  })  : _signIn = signIn,
        _signUp = signUp,
        _updateUser = updateUser,
        _forgotPassword = forgotPassword,
        _updatePassword = updatePassword,
        _saveProfilePicture = saveProfilePicture,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<UpdateUserEvent>(_updateUserHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdatePasswordEvent>(_updatePasswordHandler);
    on<SaveProfilePictureEvent>(_saveProfilePictureHandler);
    on<KeyboardOpenedEvent>(_keboardHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final UpdateUser _updateUser;
  final ForgotPassword _forgotPassword;
  final UpdatePassword _updatePassword;
  final SaveProfilePicture _saveProfilePicture;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.errorMessage,
          statusCode: failure.statusCode,
        ),
      ),
      (user) => emit(SignedIn(user: user)),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.errorMessage,
          statusCode: failure.statusCode,
        ),
      ),
      (_) => emit(const SignedUp()),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUser(
      UpdateUserParams(
        action: event.action,
        user: event.user,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.errorMessage,
          statusCode: failure.statusCode,
        ),
      ),
      (_) => emit(const UserUpdated()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPassword(event.email);

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.errorMessage,
          statusCode: failure.statusCode,
        ),
      ),
      (_) => emit(const ForgotPasswordSent()),
    );
  }

  Future<void> _updatePasswordHandler(
    UpdatePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updatePassword(
      UpdatePasswordParam(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.errorMessage,
          statusCode: failure.statusCode,
        ),
      ),
      (_) => emit(const PasswordUpdated()),
    );
  }

  Future<void> _saveProfilePictureHandler(
    SaveProfilePictureEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _saveProfilePicture(event.file);

    result.fold(
      (failure) => emit(
        AuthError(
          message: failure.errorMessage,
          statusCode: failure.statusCode,
        ),
      ),
      (urlImage) => emit(ProfilePictureSaved(urlImage: urlImage)),
    );
  }

  void _keboardHandler(
    KeyboardOpenedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(KeyboardOpened(isOpened: event.isOpened));
  }
}
