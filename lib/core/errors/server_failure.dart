import 'package:demo/core/errors/failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({required super.statusCode, super.message});

  @override
  List<Object?> get props => [message, statusCode];
}
