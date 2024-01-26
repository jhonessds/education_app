import 'dart:io';

import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class SaveProfilePicture extends UsecaseWithParam<String, File> {
  SaveProfilePicture({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<String> call(File params) async =>
      repository.saveProfilePicture(profilePicture: params);
}
