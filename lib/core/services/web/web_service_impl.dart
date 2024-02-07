import 'package:demo/core/common/models/environment_model.dart';
import 'package:demo/core/errors/server_failure.dart';
import 'package:demo/core/services/web/auth_interceptor.dart';
import 'package:demo/core/services/web/print_log_interceptor.dart';
import 'package:demo/core/services/web/web_service.dart';
import 'package:demo/core/utils/status_code.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WebServiceImpl implements WebService {
  WebServiceImpl(
    String baseUrl, {
    bool isAuthenticated = true,
  }) {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(PrintLogInterceptor());

    if (isAuthenticated) {
      _dio.interceptors.add(AuthInterceptor(_dio));
    }
  }

  factory WebServiceImpl.currencyApi() => WebServiceImpl(
        Modular.get<EnvironmentModel>().currencyApiServer,
        isAuthenticated: false,
      );

  final _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 20000),
      receiveTimeout: const Duration(milliseconds: 20000),
    ),
  );

  @override
  Future<WebResponse<List<T>>> getList<T>(
    String path,
    T Function(Map<String, dynamic>? json) parse, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await _dio.get<T>(
        path,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return WebResponse<List<T>>()..data = _parseList(result.data, parse);
    } on DioException catch (err) {
      return WebResponse<List<T>>()
        ..failure = _getFailureFromDioError(err)
        ..statusCode = err.response?.statusCode;
    } catch (e) {
      return WebResponse<List<T>>()..failure = const ServerFailure();
    }
  }

  @override
  Future<WebResponse<T>> getModel<T>(
    String path,
    T Function(Map<String, dynamic>? json) parse, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await _dio.get<T>(path, queryParameters: query);
      return WebResponse<T>()
        ..data = parse(result.data! as Map<String, dynamic>);
    } on DioException catch (err) {
      return WebResponse<T>()
        ..failure = _getFailureFromDioError(err)
        ..statusCode = err.response?.statusCode;
    } catch (e) {
      return WebResponse<T>()..failure = const ServerFailure();
    }
  }

  @override
  Future<WebResponse<List<T>>> postList<T>(
    String path,
    dynamic body,
    T Function(Map<String, dynamic>? json) parse, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await _dio.post<T>(
        path,
        data: body,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return WebResponse<List<T>>()..data = _parseList(result.data, parse);
    } on DioException catch (err) {
      return WebResponse<List<T>>()
        ..failure = _getFailureFromDioError(err)
        ..statusCode = err.response?.statusCode;
    } catch (e) {
      return WebResponse<List<T>>()..failure = const ServerFailure();
    }
  }

  @override
  Future<WebResponse<T>> postModel<T>(
    String path,
    dynamic body,
    T Function(Map<String, dynamic>? json) parse,
  ) async {
    try {
      final result = await _dio.post<T>(path, data: body);

      return WebResponse<T>()
        ..data = parse(result.data! as Map<String, dynamic>);
    } on DioException catch (err) {
      return WebResponse<T>()
        ..failure = _getFailureFromDioError(err)
        ..statusCode = err.response?.statusCode;
    } catch (e) {
      return WebResponse<T>()..failure = const ServerFailure();
    }
  }

  @override
  Future<WebResponse<T>> putModel<T>(
    String path,
    dynamic body,
    T Function(dynamic json) parse,
  ) async {
    try {
      final result = await _dio.put<T>(path, data: body);
      return WebResponse<T>()..data = parse(result.data);
    } on DioException catch (err) {
      return WebResponse<T>()
        ..failure = _getFailureFromDioError(err)
        ..statusCode = err.response?.statusCode;
    } catch (e) {
      return WebResponse<T>()..failure = const ServerFailure();
    }
  }

  @override
  Future<WebResponse<T>> deleteModel<T>(String path) async {
    try {
      await _dio.delete<T>(path);
      return WebResponse<T>();
    } on DioException catch (err) {
      return WebResponse<T>()
        ..failure = _getFailureFromDioError(err)
        ..statusCode = err.response?.statusCode;
    } catch (e) {
      return WebResponse<T>()..failure = const ServerFailure();
    }
  }

  ServerFailure _getFailureFromDioError(DioException error) {
    if (error.response == null) {
      return const ServerFailure();
    }
    var message = '';
    try {
      message = _parseErrorMessage(error.response?.data as List<dynamic>?);
    } catch (e) {
      message = e.toString();
    }

    return ServerFailure(
      message: message,
      statusCode: StatusCode.fromInt(error.response?.statusCode ?? 1),
    );
  }

  String _parseErrorMessage(List<dynamic>? data) {
    var result = '';
    if (data != null) {
      for (final element in data) {
        // ignore: use_string_buffers
        result += '$element, ';
      }
    }
    return result;
  }

  List<T> _parseList<T>(
    dynamic itens,
    T Function(Map<String, dynamic>? item) parse,
  ) =>
      (itens as List<dynamic>)
          .map((e) => parse(e as Map<String, dynamic>))
          .toList();
}
