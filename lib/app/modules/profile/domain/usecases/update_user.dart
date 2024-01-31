import 'package:demo/app/modules/profile/domain/repos/profile_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

class UpdateUser extends UsecaseWithParam<User, User> {
  UpdateUser({required this.repository});

  final ProfileRepository repository;

  @override
  ResultFuture<User> call(User params) async => repository.updateUser(
        user: params,
      );
}
