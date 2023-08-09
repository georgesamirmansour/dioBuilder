import 'package:meta/meta.dart';

/// An annotation to specify cache control settings for an HTTP request.
@immutable
class CacheControl {
  /// Creates an instance of [CacheControl] with optional parameters.
  const CacheControl({
    this.maxAge,
    this.maxStale,
    this.minFresh,
    this.noCache = false,
    this.noStore = false,
    this.noTransform = false,
    this.onlyIfCached = false,
    this.other = const [],
  });

  /// The maximum age of the cached response.
  final int? maxAge;

  /// The maximum staleness of the cached response.
  final int? maxStale;

  /// The minimum freshness of the cached response.
  final int? minFresh;

  /// Indicates whether caching should be bypassed.
  final bool noCache;

  /// Indicates whether cached responses should not be stored.
  final bool noStore;

  /// Indicates whether response transformations should be skipped.
  final bool noTransform;

  /// Indicates whether the request should only be satisfied by cached responses.
  final bool onlyIfCached;

  /// Additional cache control directives.
  final List<String> other;
}
