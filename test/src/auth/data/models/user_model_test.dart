import 'dart:convert';

import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/enums/user_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel(
    id: 'id',
    name: 'name',
    userType: UserType.unknown,
    firebaseIds: <String>[],
  );
  final tJson = fixture('user');
  final tMap = json.decode(tJson) as DataMap;

  test('Should be a subclass of [User] Entity', () async {
    // assert
    expect(tModel, isA<User>());
  });

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange
      // Act
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, isA<UserModel>());
      expect(result, equals(tModel));
    });

    // test('should throw an [Error] when the map is invalid', () {
    //   // Arrange
    //   final map = DataMap.from(tMap)..remove('uid');

    //   // Act
    //   const call = UserModel.fromMap;

    //   // Assert
    //   expect(() => call(map), throwsA(isA<Error>()));
    // });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange
      // Act
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, isA<UserModel>());
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
      final result = tModel.copyWith(name: 'Paul');
      // Assert
      expect(result.name, equals('Paul'));
    });
  });
}
