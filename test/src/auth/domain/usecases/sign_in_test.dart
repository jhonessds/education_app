import 'package:demo/app/modules/auth/domain/usecases/sign_in_with_email.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

class MockLocalUser extends Mock implements User {}

void main() {
  late MockAuthRepository repository;
  late SignInWithEmail usecase;
  late User tUser;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignInWithEmail(repository: repository);
    tUser = MockLocalUser();
  });

  test(
    'should return [LocalUser] from the [AuthRepository]',
    () async {
      when(
        () => repository.signInWithEmail(
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

      expect(result, Right<dynamic, User>(tUser));

      verify(
        () => repository.signInWithEmail(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
