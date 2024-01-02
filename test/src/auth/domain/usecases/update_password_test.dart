import 'package:dartz/dartz.dart';
import 'package:demo/src/auth/domain/usecases/update_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late UpdatePassword usecase;

  const tPassword = 'Test password';

  setUp(() {
    repository = MockAuthRepository();
    usecase = UpdatePassword(repository: repository);
  });

  test(
    'should update the password',
    () async {
      when(
        () => repository.updatePassword(
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(
        const UpdatePasswordParam(
          oldPassword: tPassword,
          newPassword: tPassword,
        ),
      );

      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repository.updatePassword(
          oldPassword: tPassword,
          newPassword: tPassword,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
