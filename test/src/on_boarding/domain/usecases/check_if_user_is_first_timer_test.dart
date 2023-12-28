import 'package:dartz/dartz.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo_mock.dart';

void main() {
  late OnBoardingRepo repository;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepo();
    usecase = CheckIfUserIsFirstTimer(repository: repository);
  });

  test('should get a response from [OnBoardingRepo.checkIfUserIsFirstTimer]',
      () async {
    // Arrange
    when(() => repository.checkIfUserIsFirstTimer()).thenAnswer(
      (_) async => const Right(true),
    );

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(true));
    verify(() => repository.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
