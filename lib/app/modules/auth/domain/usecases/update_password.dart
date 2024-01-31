import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class UpdatePassword extends UsecaseWithParam<void, UpdatePasswordParams> {
  UpdatePassword({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(UpdatePasswordParams params) async =>
      repository.updatePassword(
        newPassword: params.newPassword,
        oldPassword: params.oldPassword,
      );
}

class UpdatePasswordParams extends Equatable {
  const UpdatePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });

  final String oldPassword;
  final String newPassword;

  @override
  List<Object> get props => [oldPassword, newPassword];
}
