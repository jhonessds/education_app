import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/server_failure.dart';
import 'package:education_app/core/utils/status_code.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_datasource.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:education_app/src/auth/data/repos/auth_repository_impl.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthRepositoryImpl(remoteDataSource);
    registerFallbackValue(UpdateUserAction.password);
    registerFallbackValue(LocalUser.empty());
    registerFallbackValue(LocalUserModel.empty());
  });

  const tPassword = 'Test password';
  const tFullName = 'Test full name';
  const tEmail = 'Test email';
  const tUpdateAction = UpdateUserAction.password;

  final tUser = LocalUserModel.empty();

  const tFailure = ServerFailure(
    message: 'User does not exist',
    statusCode: StatusCode.notFound,
  );

  group('forgotPassword', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(() => remoteDataSource.forgotPassword(email: any(named: 'email')))
            .thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repositoryImpl.forgotPassword(email: tEmail);

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => remoteDataSource.forgotPassword(email: tEmail)).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.forgotPassword(email: any(named: 'email')))
            .thenThrow(tFailure);

        final result = await repositoryImpl.forgotPassword(email: tEmail);

        expect(result, equals(const Left<dynamic, void>(tFailure)));

        verify(() => remoteDataSource.forgotPassword(email: tEmail)).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signIn', () {
    test(
      'should return [LocalUser] when call to remote source is successful',
      () async {
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUser);

        final result = await repositoryImpl.signIn(
          email: tEmail,
          password: tPassword,
        );

        expect(result, equals(Right<dynamic, LocalUser>(tUser)));

        verify(
          () => remoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFailure);

        final result = await repositoryImpl.signIn(
          email: tEmail,
          password: tPassword,
        );

        expect(result, equals(const Left<dynamic, void>(tFailure)));

        verify(
          () => remoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signUp', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repositoryImpl.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFailure);

        final result = await repositoryImpl.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(result, equals(const Left<dynamic, void>(tFailure)));

        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('updateUser', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            user: any(named: 'user'),
          ),
        ).thenAnswer((_) async => Future.value());

        final result = await repositoryImpl.updateUser(
          action: tUpdateAction,
          user: tUser,
        );

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(
          () => remoteDataSource.updateUser(
            action: tUpdateAction,
            user: tUser,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            user: any(named: 'user'),
          ),
        ).thenThrow(tFailure);

        final result = await repositoryImpl.updateUser(
          action: tUpdateAction,
          user: tUser,
        );

        expect(result, equals(const Left<dynamic, void>(tFailure)));

        verify(
          () => remoteDataSource.updateUser(action: tUpdateAction, user: tUser),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
