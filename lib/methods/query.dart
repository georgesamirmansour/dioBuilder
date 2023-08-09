import 'package:meta/meta.dart';

/// An annotation to specify a query parameter for an HTTP request.
@immutable
class Query {
  /// Creates an instance of [Query] with the provided [value] and optional [encoded] flag.
  const Query(this.value, {this.encoded = false});

  /// The value of the query parameter.
  final String value;

  /// Indicates whether the query parameter should be URL-encoded.
  final bool encoded;
}
