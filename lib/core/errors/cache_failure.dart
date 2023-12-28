import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/core/utils/status_code.dart';

class CacheFailure extends Failure {
  const CacheFailure({
    super.message,
    super.statusCode = StatusCode.cache,
  });

  @override
  List<Object?> get props => [message, statusCode];
}
