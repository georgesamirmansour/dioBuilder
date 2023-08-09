import 'package:meta/meta.dart';

/// An annotation to specify a part of a multi-part HTTP request.
@immutable
class Part {
  /// Creates an instance of [Part] with optional parameters.
  const Part({
    this.name,
    this.fileName,
    this.contentType,
  });

  /// The name of the part.
  final String? name;

  /// The file name of the part.
  final String? fileName;

  /// The content type of the part.
  final String? contentType;
}
