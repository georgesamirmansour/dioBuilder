import 'package:meta/meta.dart';

/// An abstract class representing a MIME type.
abstract class _MimeType {
  /// Creates an instance of [_MimeType].
  const _MimeType();

  /// The MIME type value.
  abstract final String mime;
}


/// An annotation to specify the "application/x-www-form-urlencoded" MIME type.
@immutable
class FormUrlEncoded extends _MimeType {
  /// Creates an instance of [FormUrlEncoded].
  const FormUrlEncoded();

  /// The MIME type value for "application/x-www-form-urlencoded".
  @override
  final String mime = 'application/x-www-form-urlencoded';
}

/// An annotation to specify the "multipart/form-data" MIME type.
@immutable
class MultiPart extends _MimeType {
  /// Creates an instance of [MultiPart].
  const MultiPart();

  /// The MIME type value for "multipart/form-data".
  @override
  final String mime = 'multipart/form-data';
}
