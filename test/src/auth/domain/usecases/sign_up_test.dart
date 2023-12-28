import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late SignUp usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tFullName = 'Test full name';

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignUp(repository: repository);
  });

  test(
    'should call the [AuthRepo]',
    () async {
      when(
        () => repository.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(
        const SignUpParams(
          email: tEmail,
          password: tPassword,
          fullName: tFullName,
        ),
      );

      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repository.signUp(
          email: tEmail,
          password: tPassword,
          fullName: tFullName,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
