import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/app/modules/auth/domain/usecases/forgot_password.dart';
import 'package:demo/app/modules/auth/domain/usecases/save_profile_picture.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_in.dart';
import 'package:demo/app/modules/auth/domain/usecases/sign_up.dart';
import 'package:demo/app/modules/auth/domain/usecases/update_password.dart';
import 'package:demo/app/modules/auth/domain/usecases/update_user.dart';
import 'package:demo/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockUpdatePassword extends Mock implements UpdatePassword {}

class MockSaveProfilePicture extends Mock implements SaveProfilePicture {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late UpdatePassword updatePassword;
  late SaveProfilePicture saveProfilePicture;
  late AuthBloc bloc;

  const tSignInParams = SignInParams(email: '', password: '');
  const tSignUpParams = SignUpParams(email: '', password: '', fullName: '');
  const tUpdatePasswordParam = UpdatePasswordParam(
    newPassword: '',
    oldPassword: '',
  );
  final tUser = UserModel.empty();
  final tUpdateUserParams = UpdateUserParams(
    action: UpdateUserAction.email,
    user: tUser,
  );
  const tUrlImage = 'oi';
  final tFile = File('');
  const tServerFailure = ServerFailure(
    message: 'User not found',
    statusCode: StatusCode.userNotFound,
  );

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    updatePassword = MockUpdatePassword();
    saveProfilePicture = MockSaveProfilePicture();

    bloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
      updatePassword: updatePassword,
      saveProfilePicture: saveProfilePicture,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tUpdateUserParams);
    registerFallbackValue(tUpdatePasswordParam);
    registerFallbackValue(File(''));
  });

  tearDown(() => bloc.close());

  test('inital state should be [AuthInitial]', () async {
    expect(bloc.state, isA<AuthInitial>());
  });

  group('SignInEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedIn] when [SignInEvent] is successful',
      build: () {
        when(() => signIn.call(any())).thenAnswer(
          (_) async => Right(tUser),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        SignedIn(user: tUser),
      ],
      verify: (_) {
        verify(() => signIn.call(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when signIn fails',
      build: () {
        when(() => signIn.call(any())).thenAnswer(
          (_) async => const Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(
          message: tServerFailure.errorMessage,
          statusCode: tServerFailure.statusCode,
        ),
      ],
      verify: (_) {
        verify(() => signIn.call(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  group('SignUpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedUp] when [SignUpEvent] is successful',
      build: () {
        when(() => signUp.call(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => const [
        AuthLoading(),
        SignedUp(),
      ],
      verify: (_) {
        verify(() => signUp.call(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when signUp fails',
      build: () {
        when(() => signUp.call(any())).thenAnswer(
          (_) async => const Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSignUpParams.email,
          password: tSignUpParams.password,
          fullName: tSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(
          message: tServerFailure.errorMessage,
          statusCode: tServerFailure.statusCode,
        ),
      ],
      verify: (_) {
        verify(() => signUp.call(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });

  group('UpdateUserEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, UserUpdated] when [UpdateUserEvent] is '
      'successful',
      build: () {
        when(() => updateUser.call(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          user: tUpdateUserParams.user,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const UserUpdated(),
      ],
      verify: (_) {
        verify(() => updateUser.call(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when updateUser fails',
      build: () {
        when(() => updateUser.call(any())).thenAnswer(
          (_) async => const Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          user: tUpdateUserParams.user,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(
          message: tServerFailure.errorMessage,
          statusCode: tServerFailure.statusCode,
        ),
      ],
      verify: (_) {
        verify(() => updateUser.call(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });

  group('ForgotPasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, ForgotPasswordSent] when '
      '[ForgotPasswordEvent] is successful',
      build: () {
        when(() => forgotPassword.call(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const ForgotPasswordEvent(email: 'email')),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
      verify: (_) {
        verify(() => forgotPassword.call('email')).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when forgotPassword fails',
      build: () {
        when(() => forgotPassword.call(any())).thenAnswer(
          (_) async => const Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const ForgotPasswordEvent(email: 'email')),
      expect: () => [
        const AuthLoading(),
        AuthError(
          message: tServerFailure.errorMessage,
          statusCode: tServerFailure.statusCode,
        ),
      ],
      verify: (_) {
        verify(() => forgotPassword.call('email')).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });

  group('UpdatePasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, PasswordUpdated] when '
      '[UpdatePasswordEvent] is successful',
      build: () {
        when(() => updatePassword.call(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdatePasswordEvent(
          oldPassword: tUpdatePasswordParam.oldPassword,
          newPassword: tUpdatePasswordParam.newPassword,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const PasswordUpdated(),
      ],
      verify: (_) {
        verify(() => updatePassword.call(tUpdatePasswordParam)).called(1);
        verifyNoMoreInteractions(updatePassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when updatePassword fails',
      build: () {
        when(() => updatePassword.call(any())).thenAnswer(
          (_) async => const Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdatePasswordEvent(
          oldPassword: tUpdatePasswordParam.oldPassword,
          newPassword: tUpdatePasswordParam.newPassword,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(
          message: tServerFailure.errorMessage,
          statusCode: tServerFailure.statusCode,
        ),
      ],
      verify: (_) {
        verify(() => updatePassword.call(tUpdatePasswordParam)).called(1);
        verifyNoMoreInteractions(updatePassword);
      },
    );
  });

  group('SaveProfilePictureEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, ProfilePictureSaved] when '
      '[SaveProfilePictureEvent] is successful',
      build: () {
        when(() => saveProfilePicture.call(any())).thenAnswer(
          (_) async => const Right(tUrlImage),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(SaveProfilePictureEvent(file: tFile)),
      expect: () => [
        const AuthLoading(),
        const ProfilePictureSaved(urlImage: tUrlImage),
      ],
      verify: (_) {
        verify(() => saveProfilePicture.call(tFile)).called(1);
        expect(bloc.state.props.first, tUrlImage);
        verifyNoMoreInteractions(saveProfilePicture);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when saveProfilePicture fails',
      build: () {
        when(() => saveProfilePicture.call(any())).thenAnswer(
          (_) async => const Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(SaveProfilePictureEvent(file: tFile)),
      expect: () => [
        const AuthLoading(),
        AuthError(
          message: tServerFailure.errorMessage,
          statusCode: tServerFailure.statusCode,
        ),
      ],
      verify: (_) {
        verify(() => saveProfilePicture.call(tFile)).called(1);
        verifyNoMoreInteractions(saveProfilePicture);
      },
    );
  });
}
