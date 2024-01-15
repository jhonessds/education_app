import 'package:demo/core/errors/failure.dart';
import 'package:demo/core/utils/either.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;
typedef DataMap = Map<String, dynamic>;
