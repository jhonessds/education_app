import 'package:demo/core/abstraction/logger.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.dio);
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //logger();
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger(err);
    handler.next(err);
  }
}
