import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:education_app/src/auth/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late SignIn usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignIn(repository: repository);
  });

  final tUser = LocalUser.empty();

  test(
    'should return [LocalUser] from the [AuthRepository]',
    () async {
      when(
        () => repository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Right(tUser));

      final result = await usecase(
        const SignInParams(
          email: tEmail,
          password: tPassword,
        ),
      );

      expect(result, Right<dynamic, LocalUser>(tUser));

      verify(
        () => repository.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
