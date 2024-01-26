import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/enums/update_user.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UsecaseWithParam<void, UpdateUserParams> {
  UpdateUser({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(UpdateUserParams params) async =>
      repository.updateUser(
        user: params.user,
        action: params.action,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.user, required this.action});

  final User user;
  final UpdateUserAction action;

  @override
  List<Object> get props => [user, action];
}
