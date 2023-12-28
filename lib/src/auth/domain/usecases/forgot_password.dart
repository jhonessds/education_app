import 'package:education_app/core/usecases/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repository.dart';

class ForgotPassword extends UsecaseWithParam<void, String> {
  ForgotPassword({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call(String params) async => repository.forgotPassword(
        email: params,
      );
}
