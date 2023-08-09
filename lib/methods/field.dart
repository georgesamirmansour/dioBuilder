import 'package:meta/meta.dart';

/// An annotation to specify a form field for an HTTP request.
@immutable
class Field {
  /// Creates an instance of [Field] with the optional [value].
  const Field([this.value]);

  /// The value of the form field.
  final String? value;
}
