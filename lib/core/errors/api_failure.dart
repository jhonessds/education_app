import 'package:education_app/core/errors/failure.dart';

class ApiFailure extends Failure {
  const ApiFailure({super.message, super.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
