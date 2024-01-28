import 'package:demo/app/modules/auth/domain/repos/auth_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/utils/typedefs.dart';

class LogOut extends UsecaseWithoutParam<void> {
  LogOut({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<void> call() async => repository.logOut();
}
