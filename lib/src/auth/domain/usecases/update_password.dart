import 'package:demo/core/usecases/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/src/auth/domain/repos/auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdatePassword extends UsecaseWithParam<void, UpdatePasswordParam> {
  UpdatePassword({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(UpdatePasswordParam params) async =>
      repository.updatePassword(
        oldPassword: params.oldPassword,
        newPassword: params.newPassword,
      );
}

class UpdatePasswordParam extends Equatable {
  const UpdatePasswordParam({
    required this.oldPassword,
    required this.newPassword,
  });

  factory UpdatePasswordParam.empty() {
    return const UpdatePasswordParam(oldPassword: '', newPassword: '');
  }

  final String oldPassword;
  final String newPassword;

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
