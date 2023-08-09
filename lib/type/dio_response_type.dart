import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

/// A class representing a specific response type configuration for Dio.
@immutable
class DioResponseType {
  /// The Dio response type to be used.
  final ResponseType responseType;

  /// Creates an instance of [DioResponseType] with the specified [responseType].
  const DioResponseType(this.responseType);
}
