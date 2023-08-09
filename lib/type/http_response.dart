import 'package:dio/dio.dart';

/// A class representing an HTTP response containing data and response details.
class HttpResponse<T> {
  /// The data associated with the HTTP response.
  final T data;

  /// The original Dio response object.
  final Response response;

  /// Creates an instance of [HttpResponse] with the provided [data] and [response].
  HttpResponse(this.data, this.response);
}
