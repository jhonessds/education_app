import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/utils/typedefs.dart';

abstract class RegisterRepository {
  ResultFuture<User> registerUser(User user);
  ResultFuture<User> registerUserByEmail({
    required User user,
    required String email,
    required String password,
  });
}
