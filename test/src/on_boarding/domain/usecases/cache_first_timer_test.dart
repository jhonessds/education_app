import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/server_failure.dart';
import 'package:education_app/core/utils/status_code.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo_mock.dart';

void main() {
  late OnBoardingRepo repository;
  late CacheFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repository: repository);
  });

  test(
      'should call the [OnBoardingRepo.cacheFirstTimer]'
      ' and return the right data', () async {
    // Arrange
    when(() => repository.cacheFirstTimer()).thenAnswer(
      (_) async => const Left(
        ServerFailure(message: 'Unknow Error', statusCode: StatusCode.unknow),
      ),
    );
    // Act
    final result = await usecase();
    // Assert
    expect(
      result,
      const Left(
        ServerFailure(message: 'Unknow Error', statusCode: StatusCode.unknow),
      ),
    );
    verify(() => repository.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
