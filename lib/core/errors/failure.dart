import 'package:demo/core/utils/status_code.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure({this.message, this.statusCode})
      : assert(statusCode is StatusCode, 'Status code cannot be a ');

  final String? message;
  final StatusCode? statusCode;

  String get errorMessage => '${statusCode?.value} Error: $message';

  bool get hasRequestError => statusCode != null;
  bool get isConnectionError =>
      statusCode != null && statusCode == StatusCode.connectionError;
  bool get isServerError => statusCode != null && statusCode!.value > 500;
}
