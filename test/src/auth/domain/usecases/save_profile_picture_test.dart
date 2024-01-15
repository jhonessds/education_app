import 'dart:io';
import 'package:demo/core/utils/either.dart';
import 'package:demo/src/auth/domain/usecases/save_profile_picture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late SaveProfilePicture usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SaveProfilePicture(repository: repository);
    registerFallbackValue(File(''));
  });

  final tFile = File('');
  test(
    'should save the profile picture',
    () async {
      when(
        () => repository.saveProfilePicture(
          profilePicture: any(named: 'profilePicture'),
        ),
      ).thenAnswer((_) async => const Right(''));

      final result = await usecase(tFile);

      expect(result, const Right<dynamic, String>(''));

      verify(
        () => repository.saveProfilePicture(profilePicture: tFile),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
