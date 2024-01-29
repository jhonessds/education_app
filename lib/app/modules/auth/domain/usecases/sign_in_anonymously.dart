import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

class SignInAnonymously extends UsecaseWithoutParam<User> {
  SignInAnonymously({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<User> call() async => repository.signInAnonymously();
}
