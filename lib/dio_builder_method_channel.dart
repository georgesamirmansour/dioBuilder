import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dio_builder_platform_interface.dart';

/// An implementation of [DioBuilderPlatform] that uses method channels.
class MethodChannelDioBuilder extends DioBuilderPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dio_builder');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
