import 'package:demo/core/utils/status_code.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure({required this.statusCode, this.message});

  final String? message;
  final StatusCode statusCode;

  set message(String? value) => message = value;

  String get errorMessage => '${statusCode.name} Error: $message';
  String get errorMessageTranslated => statusCode.translated;

  bool get isConnectionError => statusCode == StatusCode.connectionError;
  bool get isServerError => statusCode.value > 500 && statusCode.value < 600;
}
