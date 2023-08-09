import 'package:meta/meta.dart';

/// An annotation to specify the request body for an HTTP request.
@immutable
class Body {
  /// Creates an instance of [Body] with an optional [nullToAbsent] flag.
  const Body({this.nullToAbsent = false});

  /// Indicates whether null values should be treated as absent in the request body.
  final bool nullToAbsent;
}
