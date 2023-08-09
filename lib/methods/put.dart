import 'package:dio_builder/methods/http_method.dart';
import 'package:meta/meta.dart';

import 'method.dart';


/// An annotation to specify an HTTP PUT method.
@immutable
class PUT extends Method {
  /// Creates an instance of [PUT] with the specified [path].
  const PUT(String path) : super(HttpMethod.PUT, path);
}
