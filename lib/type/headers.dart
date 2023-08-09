import 'package:meta/meta.dart';

/// An annotation to specify custom headers for an HTTP request.
@immutable
class Headers {
  /// Creates an instance of [Headers] with the optional [value].
  const Headers([this.value]);

  /// A map containing custom header values.
  final Map<String, dynamic>? value;
}
