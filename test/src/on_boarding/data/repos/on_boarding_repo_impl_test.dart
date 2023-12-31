import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/cache_failure.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_datasource.dart';
import 'package:education_app/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
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

  const tCacheFailure = CacheFailure(message: 'Insufficient Permission');

  group('cacheFirstTimer', () {
    test(
        'should call the [OnBoardingLocalDataSource.cacheFirstTimer] and '
        'complete successfully when the call to the remote source is '
        'successful', () async {
      // Arrange
      when(() => dataSource.cacheFirstTimer())
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.cacheFirstTimer();

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => dataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return a [CacheFailure] when the call to the data '
        'source is unsuccessful', () async {
      // Arrange
      when(
        () => dataSource.cacheFirstTimer(),
      ).thenThrow(tCacheFailure);

      // Act
      final result = await repository.cacheFirstTimer();

      // Assert
      expect(result, equals(const Left<Failure, void>(tCacheFailure)));
      verify(() => dataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test('should return true when user is first timer', () async {
      // Arrange
      when(() => dataSource.checkIfUserIsFirstTimer())
          .thenAnswer((_) async => Future.value(true));

      // Act
      final result = await repository.checkIfUserIsFirstTimer();

      // Assert
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should return false when user is not first timer', () async {
      // Arrange
      when(() => dataSource.checkIfUserIsFirstTimer())
          .thenAnswer((_) async => Future.value(false));

      // Act
      final result = await repository.checkIfUserIsFirstTimer();

      // Assert
      expect(result, equals(const Right<dynamic, bool>(false)));
      verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'should return a [CacheFailure] when call to local source is '
        'unsuccessful', () async {
      // Arrange
      when(
        () => dataSource.checkIfUserIsFirstTimer(),
      ).thenThrow(tCacheFailure);

      // Act
      final result = await repository.checkIfUserIsFirstTimer();

      // Assert
      expect(result, equals(const Left<Failure, void>(tCacheFailure)));
      verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
