import 'package:education_app/core/errors/failure.dart';

class CacheFailure extends Failure {
  const CacheFailure({super.message, super.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
