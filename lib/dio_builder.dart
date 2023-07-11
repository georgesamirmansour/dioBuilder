
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

/// class as singleton using factory design pattern
/// @see DioBuilder using builder design pattern
/// @param _dio as static
///
abstract class DioBuilder {
  /// pre-define url with live, stage, and dev
  /// must be initialized
  /// at least any one of them
  static bool _isLive = false;
  static bool _isStage = false;
  static bool _isTest = false;
  static String _liveUrl = "";
  static String _stageUrl = "";
  static String _testUrl = "";
  static bool _allowBadRequest = false;


  static final Dio _dio = Dio();

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

  /// default time out here for connection, response and request
  /// time out in seconds
  int _defaultTimeOut = 15;

  /// allow to log the http request and response in terminal with single line
  /// in case of using chunker please review library
  /// curl logs appears in terminal you can copy and past it to use it in post man
  void addLogger({bool allowChucker = true, bool printLog = true}) {
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
          maxWidth: 90));
    }
  }

  /// allow retry of connection in case of internet failed or error from api
  /// default retry as default 3
  void allowRetryInFailed({int retryCount = 3}) {
    _dio.interceptors.add(RetryInterceptor(
        dio: _dio,
        retries: retryCount,
        retryDelays: List.generate(
            retryCount, (index) => Duration(seconds: retryCount + index))));

  }

  /// this is the production url
  /// it only for production on app store on apple store when app live
  void setBaseLiveUrls(String baseUrl) {
    _liveUrl = baseUrl;

  }

  /// this is testing or development url
  void setTestUrls(String baseUrl) {
    _testUrl = baseUrl;

  }

  void allowBadRequest(bool value){
    _allowBadRequest = value;
  }

  /// in case you have a mirror of your production url but is only
  /// work in testing
  void setBaseStageUrls(String baseUrl) {
    _stageUrl = baseUrl;

  }

  void setIsLive(bool value) {
    _isLive = value;

  }

  void setIsTest(bool value) {
    _isTest = value;

  }

  void setIsStage(bool value) {
    _isStage = value;

  }

  void setDefaultTimeOut(int value) {
    _defaultTimeOut = value;

  }

  void setResponseType(ResponseType value) {
    _responseType = value;

  }

  void setContentType(String value) {
    _contentType = value;

  }

  void setPersistentConnection(bool value) {
    _persistentConnection = value;

  }

  void setFollowRedirects(bool value) {
    _followRedirects = value;

  }

  void setMaxRedirects(int value) {
    _maxRedirects = value;

  }

  void setExtras(Map<String, dynamic> value) {
    _extra = value;

  }

  void setHeaders(Map<String, dynamic> value) {
    _headers = value;

  }

  void queryParameters(Map<String, dynamic> value) {
    _queryParameters = value;

  }

  void setListFormat(ListFormat value) {
    _listFormat = value;

  }

  void setMethod(String value) {
    _method = value;

  }

  void setReceiveDataWhenStatusError(bool value) {
    _receiveDataWhenStatusError = value;
  }

  // List<int> setRequestEncode(String request, RequestOptions options) ;
  //
  // String setResponseDecoder(List<int> responseBytes, RequestOptions options,
  //     ResponseBody responseBody);

  /// check if their is connection between server and client
  /// also detect if their is ping
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(_baseUrl());
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Future.value(true);
      }
    } on SocketException {
      return Future.value(false);
    }
    return Future.value(false);
  }

  /// use this method for build with builder pattern
  /// it build with default config first time
  Dio build() {
    addLogger();
    allowRetryInFailed();
    _dio.options = _buildBaseOption();
    _dio.interceptors.add(_interceptorsWrapper);
    if(_allowBadRequest){
      _dio.httpClientAdapter = Http2Adapter(ConnectionManager(
        idleTimeout: const Duration(seconds: 10),
        onClientCreate:  (_, config) => config.onBadCertificate = (_) => true,
      ));
    }
    return _dio;
  }

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
    // responseDecoder: (responseBytes, options, responseBody) =>
    //     setResponseDecoder(responseBytes, options, responseBody),
    // requestEncoder: (request, options) =>
    //     setRequestEncode(request, options),
    extra: _extra,
    headers: _headers,
    listFormat: _listFormat,
    method: _method,
    queryParameters: _queryParameters,
    receiveDataWhenStatusError: _receiveDataWhenStatusError,
  );

  String _baseUrl() {
    if (_isLive && _liveUrl.isNotEmpty) {
      return _liveUrl;
    } else if (_isStage && _stageUrl.isNotEmpty) {
      return _stageUrl;
    } else if (_isTest && _testUrl.isNotEmpty) {
      return _testUrl;
    } else {
      throw Exception("no url has been allowed to use yet");
    }
  }

  InterceptorsWrapper get _interceptorsWrapper => InterceptorsWrapper(
    onError: (dioException, handler) => handleOnError(dioException, handler),
    onRequest: (options, handler) => handleOnRequest(options, handler),
    onResponse: (response, handler) => handleOnResponse(response, handler),
  );

  handleOnError(DioException dioException, ErrorInterceptorHandler handler);

  handleOnRequest(RequestOptions options, RequestInterceptorHandler handler);

  handleOnResponse(Response<dynamic> response, ResponseInterceptorHandler handler);
}
