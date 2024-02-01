import 'dart:io';

import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

abstract class ProfileRepository {
  const ProfileRepository();

  ResultFuture<User> updateUser({required User user});
  ResultFuture<User> saveProfilePicture({required File profilePicture});
  ResultFuture<bool> deleteUser({required String userId});
}
