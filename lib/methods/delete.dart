import 'package:dio_builder/methods/http_method.dart';
import 'package:dio_builder/methods/method.dart';
import 'package:meta/meta.dart';

/// An annotation to specify an HTTP DELETE method.
@immutable
class DELETE extends Method {
  /// Creates an instance of [DELETE] with the specified [path].
  const DELETE(String path) : super(HttpMethod.DELETE, path);
}
