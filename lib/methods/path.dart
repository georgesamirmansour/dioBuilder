import 'package:meta/meta.dart';

/// An annotation to specify a path parameter for an HTTP request.
@immutable
class Path {
  /// Creates an instance of [Path] with the optional [value].
  const Path([this.value]);

  /// The value of the path parameter.
  final String? value;
}
