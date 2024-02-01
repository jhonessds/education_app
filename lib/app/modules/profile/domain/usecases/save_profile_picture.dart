import 'dart:io';

import 'package:demo/app/modules/profile/domain/repos/profile_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

class SaveProfilePicture extends UsecaseWithParam<User, File> {
  SaveProfilePicture({required this.repository});

  final ProfileRepository repository;

  @override
  ResultFuture<User> call(File params) async => repository.saveProfilePicture(
        profilePicture: params,
      );
}
