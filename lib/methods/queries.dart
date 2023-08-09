import 'package:meta/meta.dart';

/// An annotation to specify query parameters for an HTTP request.
@immutable
class Queries {
  /// Creates an instance of [Queries] with the optional [encoded] flag.
  const Queries({this.encoded = false});

  /// Indicates whether query parameters should be URL-encoded.
  final bool encoded;
}
