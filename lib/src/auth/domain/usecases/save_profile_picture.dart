import 'dart:io';
import 'package:education_app/core/usecases/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repository.dart';

class SaveProfilePicture extends UsecaseWithParam<String, File> {
  SaveProfilePicture({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<String> call(File params) async =>
      repository.saveProfilePicture(profilePicture: params);
}
