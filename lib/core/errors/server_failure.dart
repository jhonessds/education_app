import 'package:demo/core/errors/failure.dart';
import 'package:demo/core/utils/status_code.dart';

class ServerFailure extends Failure {
  const ServerFailure({
    super.statusCode = StatusCode.problemWithRequest,
    super.message,
  });

  @override
  List<Object?> get props => [message, statusCode];
}
