import 'package:meta/meta.dart';

/// An annotation to specify an HTTP method and its path.
@immutable
class Method {
  /// Creates an instance of [Method] with the provided [method] and [path].
  const Method(
      this.method,
      this.path,
      );

  /// The HTTP method to be used.
  final String method;

  /// The path for the HTTP request.
  final String path;
}
