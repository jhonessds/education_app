import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class EmailHasVerified extends UsecaseWithoutParam<bool> {
  EmailHasVerified({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<bool> call() => repository.emailHasVerified();
}