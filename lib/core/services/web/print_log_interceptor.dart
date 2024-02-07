import 'package:demo/core/abstraction/logger.dart';
import 'package:dio/dio.dart';

class PrintLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger(
      'PrintLogInterceptor ${DateTime.now()} - [${options.method}]'
      ' ${options.uri}',
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger(
      'PrintLogInterceptor ${DateTime.now()} -'
      ' [${response.requestOptions.method} ${response.statusCode}]'
      ' ${response.requestOptions.uri}',
    );

    if (response.statusCode != 200) logger(response.data);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      logger(
        'PrintLogInterceptor ${DateTime.now()} - [DIO_ERROR]'
        ' ${err.response?.statusCode} | ${err.response?.statusMessage}',
      );
    } else {
      logger(
        'PrintLogInterceptor ${DateTime.now()} - [DIO_ERROR] ${err.message}',
      );
    }

    return super.onError(err, handler);
  }
}
