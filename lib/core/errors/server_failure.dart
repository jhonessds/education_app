import 'package:demo/core/errors/failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({super.message, super.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
