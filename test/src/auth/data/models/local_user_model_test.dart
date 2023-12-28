import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = LocalUserModel(
    uid: 'uid',
    email: 'email',
    fullName: 'fullName',
  );
  final tJson = fixture('user');
  final tMap = json.decode(tJson) as DataMap;

  test('Should be a subclass of [LocalUser] Entity', () async {
    // assert
    expect(tModel, isA<LocalUser>());
  });

  group('fromMap', () {
    test('should return a [LocalUserModel] with the right data', () {
      // Arrange
      // Act
      final result = LocalUserModel.fromMap(tMap);

      // Assert
      expect(result, isA<LocalUserModel>());
      expect(result, equals(tModel));
    });

    // test('should throw an [Error] when the map is invalid', () {
    //   // Arrange
    //   final map = DataMap.from(tMap)..remove('uid');

    //   // Act
    //   const call = LocalUserModel.fromMap;

    //   // Assert
    //   expect(() => call(map), throwsA(isA<Error>()));
    // });
  });

  group('fromJson', () {
    test('should return a [LocalUserModel] with the right data', () {
      // Arrange
      // Act
      final result = LocalUserModel.fromJson(tJson);

      // Assert
      expect(result, isA<LocalUserModel>());
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      // Act
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] string with the right data', () {
      // Act
      final result = tModel.toJson();
      // Assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      // Act
      final result = tModel.copyWith(fullName: 'Paul');
      // Assert
      expect(result.fullName, equals('Paul'));
    });
  });
}
