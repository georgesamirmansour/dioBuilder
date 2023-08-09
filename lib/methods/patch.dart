import 'package:dio_builder/methods/http_method.dart';
import 'package:meta/meta.dart';

import 'method.dart';

/// An annotation to specify an HTTP PATCH method.
@immutable
class PATCH extends Method {
  /// Creates an instance of [PATCH] with the specified [path].
  const PATCH(String path) : super(HttpMethod.PATCH, path);
}
