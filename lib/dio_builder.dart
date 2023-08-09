import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

export 'dart:io';

export 'package:chucker_flutter/chucker_flutter.dart';
export 'package:dio/dio.dart';
export 'package:dio_smart_retry/dio_smart_retry.dart';
export 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// The `DioBuilder` class provides a builder pattern for configuring and creating instances of the Dio HTTP client.
/// It abstracts common configurations and interceptors for making HTTP requests.
abstract class DioBuilder {
  static bool _allowBadRequest = false;
  static bool _isLive = false;
  static bool _isStage = false;
  static bool _isTest = false;
  static String _liveUrl = "";
  static String _stageUrl = "";
  static String _testUrl = "";

  final Dio _dio = Dio();

  ResponseType _responseType = ResponseType.json;
  String _contentType = "application/json";
  bool _persistentConnection = true;
  bool _followRedirects = true;
  int _maxRedirects = 5;
  ListFormat _listFormat = ListFormat.multiCompatible;
  String? _method;
  Map<String, dynamic>? _extra;
  Map<String, dynamic>? _headers;
  Map<String, dynamic>? _queryParameters;
  bool _receiveDataWhenStatusError = true;
  int _defaultTimeOut = 15;
  bool _allowRetry = true;


  /// Adds a logger interceptor to the Dio client for logging HTTP requests and responses.
  /// The logger can be printed to the console or integrated with the Chucker library for more detailed logs.
  DioBuilder addLogger({bool allowChucker = true, bool printLog = true}) {
    if (allowChucker) {
      _dio.interceptors.add(ChuckerDioInterceptor());
    }
    if (printLog) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
    return this;
  }

  /// Adds a retry interceptor to the Dio client for automatically retrying failed requests.
  /// The number of retries can be specified with the `retryCount` parameter (default is 3).
  DioBuilder allowRetryInFailed({int retryCount = 3}) {
    if(_allowRetry){
      _dio.interceptors.add(RetryInterceptor(
        dio: _dio,
        retries: retryCount,
        retryDelays: List.generate(
          retryCount,
              (index) => Duration(seconds: retryCount + index),
        ),
      ));
    }
    return this;
  }

  /// Sets the base URL for the live environment.
  /// This URL is used when the application is in production and deployed to app stores.
  void setBaseLiveUrl(String baseUrl) {
    _liveUrl = baseUrl;
  }

  /// Sets the base URL for the testing or development environment.
  DioBuilder setBaseTestUrl(String baseUrl) {
    _testUrl = baseUrl;
    return this;
  }

  /// Sets the base URL for the staging environment.
  DioBuilder setBaseStageUrl(String baseUrl) {
    _stageUrl = baseUrl;
    return this;
  }

  DioBuilder allowRetry(bool allowRetry){
    _allowRetry = allowRetry;
    return this;
  }

  /// Enables or disables the ability to handle bad SSL certificates or invalid HTTPS connections.
  /// This can be useful for testing or development purposes but should be used with caution.
  DioBuilder allowBadRequest(bool value) {
    _allowBadRequest = value;
    return this;
  }

  /// Sets the environment to live mode.
  DioBuilder setIsLive(bool value) {
    _isLive = value;
    return this;
  }

  /// Sets the environment to test mode.
  DioBuilder setIsTest(bool value) {
    _isTest = value;
    return this;
  }

  /// Sets the environment to stage mode.
  DioBuilder setIsStage(bool value) {
    _isStage = value;
    return this;
  }

  /// Sets the default timeout for network requests, in seconds.
  DioBuilder setDefaultTimeOut(int value) {
    _defaultTimeOut = value;
    return this;
  }

  /// Sets the response type for the HTTP requests.
  DioBuilder setResponseType(ResponseType value) {
    _responseType = value;
    return this;
  }

  /// Sets the content type for the HTTP requests.
  DioBuilder setContentType(String value) {
    _contentType = value;
    return this;
  }

  /// Sets whether the connection should be persistent or not.
  DioBuilder setPersistentConnection(bool value) {
    _persistentConnection = value;
    return this;
  }

  /// Sets whether the client should follow redirects or not.
  DioBuilder setFollowRedirects(bool value) {
    _followRedirects = value;
    return this;
  }

  /// Sets the maximum number of redirects to follow.
  DioBuilder setMaxRedirects(int value) {
    _maxRedirects = value;
    return this;
  }

  /// Sets extra options to be included in the requests.
  DioBuilder setExtras(Map<String, dynamic> value) {
    _extra = value;
    return this;
  }

  /// Sets the headers to be included in the requests.
  DioBuilder setHeaders(Map<String, dynamic> value) {
    _headers = value;
    return this;
  }

  /// Sets the query parameters to be included in the requests.
  DioBuilder queryParameters(Map<String, dynamic> value) {
    _queryParameters = value;
    return this;
  }

  /// Sets the format for lists serialization in the requests.
  DioBuilder setListFormat(ListFormat value) {
    _listFormat = value;
    return this;
  }

  /// Sets the HTTP method for the requests.
  DioBuilder setMethod(String value) {
    _method = value;
    return this;
  }

  /// Sets whether to receive the response data when the status is an error or not.
  void setReceiveDataWhenStatusError(bool value) {
    _receiveDataWhenStatusError = value;
  }

  /// Checks if there is an internet connection between the client and server.
  /// Returns `true` if there is a connection, otherwise `false`.
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(_baseUrl());
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  /// Builds the Dio client with the configured options and interceptors.
  Dio build() {
    addLogger();
    allowRetryInFailed();
    _dio.options = _buildBaseOption();
    _dio.interceptors.add(_interceptorsWrapper);
    if (_allowBadRequest) {
      _dio.httpClientAdapter = Http2Adapter(ConnectionManager(
        idleTimeout: const Duration(seconds: 10),
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ));
    }
    return _dio;
  }

  /// Builds the base options for the Dio client.
  BaseOptions _buildBaseOption() => BaseOptions(
        baseUrl: _baseUrl(),
        connectTimeout: Duration(seconds: _defaultTimeOut),
        receiveTimeout: Duration(seconds: _defaultTimeOut),
        sendTimeout: Duration(seconds: _defaultTimeOut),
        responseType: _responseType,
        contentType: _contentType,
        persistentConnection: _persistentConnection,
        followRedirects: _followRedirects,
        maxRedirects: _maxRedirects,
        extra: _extra,
        headers: _headers,
        listFormat: _listFormat,
        method: _method,
        queryParameters: _queryParameters,
        receiveDataWhenStatusError: _receiveDataWhenStatusError,
      );

  /// Returns the base URL based on the current environment.
  String _baseUrl() {
    if (_isLive && _liveUrl.isNotEmpty) {
      return _liveUrl;
    } else if (_isStage && _stageUrl.isNotEmpty) {
      return _stageUrl;
    } else if (_isTest && _testUrl.isNotEmpty) {
      return _testUrl;
    } else {
      throw Exception("No URL has been allowed for use yet.");
    }
  }

  /// Wraps the interceptors for error, request, and response.
  InterceptorsWrapper get _interceptorsWrapper => InterceptorsWrapper(
        onError: (dioException, handler) =>
            handleOnError(dioException, handler),
        onRequest: (options, handler) => handleOnRequest(options, handler),
        onResponse: (response, handler) => handleOnResponse(response, handler),
      );

  /// Handles the error that occurred during the HTTP request.
  void handleOnError(
      DioException dioException, ErrorInterceptorHandler handler);

  /// Handles the request before it is sent.
  void handleOnRequest(
      RequestOptions options, RequestInterceptorHandler handler);

  /// Handles the response after it is received.
  void handleOnResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler);
}
