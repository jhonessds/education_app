import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';
import 'package:equatable/equatable.dart';

import 'package:education_app/core/usecases/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repository.dart';

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

  final LocalUser user;
  final UpdateUserAction action;

  factory UpdateUserParams.empty() {
    return UpdateUserParams(
      user: LocalUser.empty(),
      action: UpdateUserAction.email,
    );
  }

  @override
  List<Object> get props => [user, action];
}
