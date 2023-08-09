import 'package:dio_builder/methods/http_method.dart';
import 'package:dio_builder/methods/method.dart';
import 'package:meta/meta.dart';

/// An annotation to specify an HTTP HEAD method.
@immutable
class HEAD extends Method {
  /// Creates an instance of [HEAD] with the specified [path].
  const HEAD(String path) : super(HttpMethod.HEAD, path);
}
