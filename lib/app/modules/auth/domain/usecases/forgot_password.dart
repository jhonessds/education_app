import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';

class ForgotPassword extends UsecaseWithParam<void, String> {
  ForgotPassword({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(String params) async => repository.forgotPassword(
        email: params,
      );
}
