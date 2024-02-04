import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class SendEmailVerification extends UsecaseWithoutParam<void> {
  SendEmailVerification({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call() async => repository.sendEmailVerification();
}
