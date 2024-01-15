import 'package:demo/core/utils/either.dart';
import 'package:demo/core/errors/failure.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:demo/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:demo/src/on_boarding/domain/usecases/cache_first_timer.dart';
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
        ServerFailure(message: 'Unknow Error', statusCode: StatusCode.unknown),
      ),
    );
    // Act
    final result = await usecase();
    // Assert
    expect(
      result,
      const Left<Failure, void>(
        ServerFailure(message: 'Unknow Error', statusCode: StatusCode.unknown),
      ),
    );
    verify(() => repository.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
