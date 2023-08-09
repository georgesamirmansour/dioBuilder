import 'package:meta/meta.dart';

import 'http_method.dart';
import 'method.dart';

/// An annotation to specify an HTTP GET method.
@immutable
class GET extends Method {
  /// Creates an instance of [GET] with the specified [path].
  const GET(String path) : super(HttpMethod.GET, path);
}
