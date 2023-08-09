import 'package:meta/meta.dart';

import 'http_method.dart';
import 'method.dart';

/// An annotation to specify an HTTP OPTIONS method.
@immutable
class OPTIONS extends Method {
  /// Creates an instance of [OPTIONS] with the specified [path].
  const OPTIONS(String path) : super(HttpMethod.OPTIONS, path);
}
