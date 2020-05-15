import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import './exceptions.dart';
import './interceptors/interceptors.dart';

import 'api_connection_constants.dart';
import 'env.dart';

class ApiEndpoints {
  Dio _dio;
  final Logger _logger = new Logger("ApiEndpoints");

  ApiEndpoints() {
    _dio = Dio();

    _dio.options.connectTimeout = connectionTimeout;
    _dio.options.receiveTimeout = connectionReadTimeout;

    var loggingInterceptor = getLoggingInterceptor();
    var errorInterceptor = getErrorInterceptor(loggingInterceptor);
    var responseInterceptor = getResponseInterceptor(loggingInterceptor);
    var requestInterceptor = getRequestInterceptor(loggingInterceptor);

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) async =>
            await requestInterceptor.getRequestInterceptor(options),
        onResponse: (Response response) =>
            responseInterceptor.getResponseInterceptor(response),
        onError: (DioError dioError) =>
            errorInterceptor.getErrorInterceptors(dioError)));
  }

  String _getFullUrlPath(String path) {
    return '$API_ENDPOINT' + path + '.json';
  }

  String _handleError(DioError error, Response response) {
    dynamic errorJsonValue = json.decode(response.data);
    String errorDescription = "";
    String detail = errorJsonValue['title'];
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription = errorJsonValue['message'];
        detail = errorJsonValue['title'];
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
    }
    return '$errorDescription: $detail';
  }

  dynamic _handleResponseError(DioError error, Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(_handleError(error, response));
      case 401:
      case 403:
      case 404:
        throw UnauthorisedException(_handleError(error, response));
      case 500:
      default:
        throw FetchDataException(_handleError(error, response));
    }
  }

  Map<String, String> _getHttpHeaders(String authToken) {
    if (authToken != null) {
      return {
        "content-type": "application/json",
        "authorization": "Bearer $authToken"
      };
    } else {
      return {
        "content-type": "application/json",
      };
    }
  }

  Future<dynamic> get(String token, String path) async {
    String url = _getFullUrlPath(path);
    try {
      Response response = await _dio.get(
        Uri.encodeFull(url),
        options: Options(headers: _getHttpHeaders(token)),
      );
      return response.toString();
    } catch (error, stacktrace) {
      _logger.log(Level.INFO,
          "Exception occured: $error stack trace: ${stacktrace.toString()}");
      if (error is DioError) {
        throw _handleResponseError(error, error.response);
      } else {
        throw BadRequestException("Exception occured: $error stack trace: ${stacktrace.toString()}");
      }
    }
  }

  Future<dynamic> put(String token, String path, dynamic data) async {
    String url = _getFullUrlPath(path);
    try {
      Response response = await _dio.put(
        Uri.encodeFull(url),
        data: json.encode(data),
        options: Options(headers: _getHttpHeaders(token)),
      );
      return response.toString();
    } catch (error, stacktrace) {
      _logger.log(Level.INFO,
          "Exception occured: $error stack trace: ${stacktrace.toString()}");
      if (error is DioError) {
        throw _handleResponseError(error, error.response);
      } else {
        throw BadRequestException(_handleError(error, error.response.data));
      }
    }
  }

  Future<dynamic> delete(String token, String path) async {
    String url = _getFullUrlPath(path);
    try {
      Response response = await _dio.delete(
        Uri.encodeFull(url),
        options: Options(headers: _getHttpHeaders(token)),
      );
      return response.toString();
    } catch (error, stacktrace) {
      _logger.log(Level.INFO,
          "Exception occured: $error stack trace: ${stacktrace.toString()}");
      if (error is DioError) {
        throw _handleResponseError(error, error.response);
      } else {
        throw BadRequestException(_handleError(error, error.response.data));
      }
    }
  }

  Future<dynamic> postDynamic(String token, String urlBasePath, dynamic data) async {
    String url = _getFullUrlPath(urlBasePath);
    try {
      Response response = await _dio.post(
        Uri.encodeFull(url),
        data: data,
        options: Options(headers: _getHttpHeaders(token)),
      );
      return response;
    } catch (error, stacktrace) {
      _logger.log(Level.INFO,
          "Exception occured: $error stack trace: ${stacktrace.toString()}");
      if (error is DioError) {
        throw _handleResponseError(error, error.response);
      } else {
        throw BadRequestException(_handleError(error, error.response.data));
      }
    }
  }

  Future<String> post(String token, String urlBasePath, dynamic data) async {
    String url = _getFullUrlPath(urlBasePath);
    try {
      Response response = await _dio.post(
        Uri.encodeFull(url),
        data: data,
        options: Options(headers: _getHttpHeaders(token)),
      );
      return response.toString();
    } catch (error, stacktrace) {
      _logger.log(Level.INFO,
          "Exception occured: $error stack trace: ${stacktrace.toString()}");
      if (error is DioError) {
        throw _handleResponseError(error, error.response);
      } else {
        throw BadRequestException(_handleError(error, error.response.data));
      }
    }
  }

  Future<dynamic> uploadFile(
      String authToken, String urlBasePath, File file) async {
    String url = _getFullUrlPath(urlBasePath);
    var len = await file.length();
    try {
      Response response = await _dio.post(url,
          data: file.openRead(),
          options: Options(headers: {
            "content-type": "application/json",
            "authorization": "Bearer $authToken",
            Headers.contentLengthHeader: len,
          }));
      return response.toString();
    } catch (error, stacktrace) {
      _logger.log(Level.INFO,
          "Exception occured: $error stack trace: ${stacktrace.toString()}");
      if (error is DioError) {
        throw _handleResponseError(error, error.response);
      } else {
        throw BadRequestException(_handleError(error, error.response.data));
      }
    }
  }

  Future<dynamic> uploadFiles(String authToken, String url,
      Map<String, dynamic> data, Map<String, File> files) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] = MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    data.addAll(fileMap);
    try {
      var formData = FormData.fromMap(data);
      Dio dio = new Dio();
      Response response = await dio.post(url,
          data: formData,
          options: Options(
            headers: {
              "content-type": "application/json",
              "authorization": "Bearer $authToken",
            },
            contentType: 'multipart/form-data',
          ));
      return response.toString();
    } catch (error, stacktrace) {
      _logger.log(Level.INFO,
          "Exception occured: $error stack trace: ${stacktrace.toString()}");
      if (error is DioError) {
        throw _handleResponseError(error, error.response);
      } else {
        throw BadRequestException(_handleError(error, error.response.data));
      }
    }
  }
}
