import 'package:demo/core/utils/either.dart';
import 'package:demo/src/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = ForgotPassword(repository: repository);
  });

  test(
    'should call the [AuthRepo.forgotPassword]',
    () async {
      when(() => repository.forgotPassword(email: any(named: 'email')))
          .thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase('email');

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.forgotPassword(email: 'email')).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
