import 'package:demo/app/modules/profile/domain/repos/profile_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class DeleteUser extends UsecaseWithParam<bool, String> {
  DeleteUser({required this.repository});

  final ProfileRepository repository;

  @override
  ResultFuture<bool> call(String params) async => repository.deleteUser(
        userId: params,
      );
}
