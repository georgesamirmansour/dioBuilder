import 'package:meta/meta.dart';

/// An annotation to specify a single custom header for an HTTP request.
@immutable
class Header {
  /// Creates an instance of [Header] with the provided [value].
  const Header(this.value);

  /// The value of the custom header.
  final String value;
}
