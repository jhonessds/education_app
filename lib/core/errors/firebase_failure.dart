import 'package:demo/core/errors/failure.dart';

class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.statusCode, super.message});

  @override
  List<Object?> get props => [message, statusCode];
}
