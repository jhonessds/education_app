import 'package:demo/core/utils/typedefs.dart';

abstract class UsecaseWithParam<T, Params> {
  const UsecaseWithParam();
  ResultFuture<T> call(Params params);
}

abstract class UsecaseWithoutParam<T> {
  const UsecaseWithoutParam();
  ResultFuture<T> call();
}
