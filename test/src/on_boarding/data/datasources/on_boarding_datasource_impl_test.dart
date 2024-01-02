import 'package:demo/core/errors/cache_failure.dart';
import 'package:demo/src/on_boarding/data/datasources/on_boarding_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSrcImpl dataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    dataSource = OnBoardingLocalDataSrcImpl(prefs: prefs);
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to cache the data', () async {
      // Arrange
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

      // Act
      await dataSource.cacheFirstTimer();

      // Assert
      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should throw [CacheFailure] when there is an error caching the data',
        () async {
      // Arrange
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      // Act
      final methodCall = dataSource.cacheFirstTimer;

      // Assert
      expect(methodCall, throwsA(isA<CacheFailure>()));
      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should call [SharedPreferences] to check if user is first timer '
        'and return the right response from storage when data exists',
        () async {
      // Arrange
      when(() => prefs.getBool(any())).thenReturn(false);

      // Act
      final result = await dataSource.checkIfUserIsFirstTimer();

      // Assert
      expect(result, false);
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return true if there is no data in storage', () async {
      // Arrange
      when(() => prefs.getBool(any())).thenReturn(null);

      // Act
      final result = await dataSource.checkIfUserIsFirstTimer();

      // Assert
      expect(result, true);
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw [CacheFailure] when there is an error retrieving '
        'the data', () async {
      // Arrange
      when(() => prefs.getBool(any())).thenThrow(Exception());

      // Act
      final methodCall = dataSource.checkIfUserIsFirstTimer;

      // Assert
      expect(methodCall, throwsA(isA<CacheFailure>()));
      verify(() => prefs.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
}
