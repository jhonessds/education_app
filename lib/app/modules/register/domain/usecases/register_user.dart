import 'package:demo/app/modules/register/domain/repos/register_repository.dart';
import 'package:demo/core/abstraction/usecase.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

class RegisterUser extends UsecaseWithParam<User, User> {
  RegisterUser({required this.repository});

  final RegisterRepository repository;

  @override
  ResultFuture<User> call(User params) async => repository.registerUser(params);
}
