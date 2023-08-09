import 'package:dio_builder/methods/http_method.dart';
import 'package:meta/meta.dart';

import 'method.dart';

/// An annotation to specify an HTTP POST method.
@immutable
class POST extends Method {
  /// Creates an instance of [POST] with the specified [path].
  const POST(String path) : super(HttpMethod.POST, path);
}
