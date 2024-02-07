// ignore_for_file: constant_identifier_names
import 'dart:async';
import "package:dio/dio.dart";

const BASEURL = "https://api.themoviedb.org/3";

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  late Dio dio;

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions();
    options.headers = {"Access-Control-Allow-Origin": "*"};
    options.baseUrl = BASEURL;
    options.receiveTimeout = const Duration(seconds: 15);
    options.connectTimeout = const Duration(seconds: 15);
    options.contentType = 'application/json';

    dio = Dio(options);

    // dio.interceptors.add(CookieManager(CookieJar()));
    // 添加攔截
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      handler.next(options);
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
    }, onError: (DioException error, handler) async {
      // Do something with response error
      if (error.response?.statusCode == 405) {
        // return _retry(error.requestOptions);
      }
      return handler.next(error);
    }));
  }

  Future get(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var response = await dio.get(path, queryParameters: params, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      // throw createErrorEntity(e);
      createErrorEntity(e);
      return e;
    }
  }

  Future post(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var response = await dio.post(path, options: options, data: params, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      // throw createErrorEntity(e);
      createErrorEntity(e);
      return e;
    }
  }

  Future put(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var response = await dio.put(path, data: params, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      // throw createErrorEntity(e);
      createErrorEntity(e);
      return e;
    }
  }

  Future patch(String path, {dynamic params, Options? options, CancelToken? cancelToken}) async {
    try {
      var response = await dio.patch(path, data: params, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      // throw createErrorEntity(e);
      createErrorEntity(e);
      return e;
    }
  }

  Future delete(String path, {dynamic params, Options? options, Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    try {
      var response = await dio.delete(path, data: params, queryParameters: queryParameters, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      // throw createErrorEntity(e);
      createErrorEntity(e);
      return e;
    }
  }

  /*
    error handle
   */
  ErrorEntity createErrorEntity(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ErrorEntity(code: -1, message: "Request cancel");

      case DioExceptionType.connectionTimeout:
        return ErrorEntity(code: -1, message: "Connect timeout");

      case DioExceptionType.sendTimeout:
        return ErrorEntity(code: -1, message: "Send timeout");

      case DioExceptionType.receiveTimeout:
        return ErrorEntity(code: -1, message: "Receive timeout");

      case DioExceptionType.badResponse:
        try {
          int errCode = error.response?.statusCode ?? 999;
          // String errMsg = error.response.statusMessage;
          // return ErrorEntity(code: errCode, message: errMsg);
          switch (errCode) {
            case 400:
              return ErrorEntity(code: errCode, message: "Bad Request (syntex error)");

            case 401:
              return ErrorEntity(code: errCode, message: "Unauthorized");

            case 403:
              return ErrorEntity(code: errCode, message: "Forbidden");

            case 404:
              return ErrorEntity(code: errCode, message: "Not found");

            case 405:
              return ErrorEntity(code: errCode, message: "Request method error");

            case 500:
              return ErrorEntity(code: errCode, message: "Server internal error");

            case 502:
              return ErrorEntity(code: errCode, message: "Bad Gateway");

            case 503:
              return ErrorEntity(code: errCode, message: "Service Unavailable");

            case 505:
              return ErrorEntity(code: errCode, message: "HTTP Version Not Supported");

            default:
              {
                return ErrorEntity(code: errCode, message: error.response?.statusMessage ?? "");
              }
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: "Unknown error");
        }

      default:
        return ErrorEntity(code: -1, message: 'default Dio exception');
    }
  }
}

//異常處理
class ErrorEntity implements Exception {
  int code;
  String message;
  ErrorEntity({required this.code, required this.message});

  String toString() {
    if (message.isEmpty) return "Exception";
    return "Exception: code $code, $message";
  }
}
