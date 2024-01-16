import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/utils/either.dart';
import 'package:demo/src/auth/data/models/local_user_model.dart';
import 'package:demo/src/auth/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late UpdateUser usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = UpdateUser(repository: repository);
    registerFallbackValue(UpdateUserAction.email);
    registerFallbackValue(LocalUserModel.empty());
  });

  final tLocalUser = LocalUserModel.empty();

  test(
    'should call the [AuthRepository]',
    () async {
      when(
        () => repository.updateUser(
          action: any(named: 'action'),
          user: any(named: 'user'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(
        UpdateUserParams(
          action: UpdateUserAction.email,
          user: tLocalUser,
        ),
      );

      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repository.updateUser(
          action: UpdateUserAction.email,
          user: tLocalUser,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
