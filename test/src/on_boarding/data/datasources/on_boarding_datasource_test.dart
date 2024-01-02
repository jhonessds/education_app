import 'package:dartz/dartz.dart';
import 'package:demo/core/errors/cache_failure.dart';
import 'package:demo/src/on_boarding/data/datasources/on_boarding_datasource.dart';
import 'package:demo/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:demo/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource dataSource;
  late OnBoardingRepoImpl repository;

  setUp(() {
    dataSource = MockOnBoardingLocalDataSource();
    repository = OnBoardingRepoImpl(localDataSource: dataSource);
  });

  test('should be a subclass of [OnBoardingRepo]', () {
    expect(repository, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    const tCacheFailure = CacheFailure(message: 'Insufficient Permission');
    test('should complete successfully when call to local source is successful',
        () async {
      // Arrange
      when(() => dataSource.cacheFirstTimer()).thenAnswer(
        (_) async => Future.value(),
      );

      // Act
      final result = await repository.cacheFirstTimer();

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => dataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return [CacheFailure] when call to local source is'
        ' unsuccessful', () async {
      // Arrange
      when(() => dataSource.cacheFirstTimer()).thenThrow(tCacheFailure);

      // Act
      final result = await repository.cacheFirstTimer();

      // Assert
      expect(result, equals(const Left<CacheFailure, dynamic>(tCacheFailure)));
      verify(() => dataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
