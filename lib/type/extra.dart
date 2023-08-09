import 'package:meta/meta.dart';

/// A class for holding extra data to be passed to Dio's request, response, transformers, and interceptors.
@immutable
class Extra {
  /// The data map containing extra information.
  final Map<String, Object> data;

  /// Creates an instance of [Extra] with the provided [data].
  /// The [data] will be passed to Dio's request, response, transformers, and interceptors.
  const Extra(this.data);
}
