import 'package:flutter_test/flutter_test.dart';
import 'package:dio_builder/dio_builder.dart';
import 'package:dio_builder/dio_builder_platform_interface.dart';
import 'package:dio_builder/dio_builder_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDioBuilderPlatform
    with MockPlatformInterfaceMixin
    implements DioBuilderPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DioBuilderPlatform initialPlatform = DioBuilderPlatform.instance;

  test('$MethodChannelDioBuilder is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDioBuilder>());
  });

  test('getPlatformVersion', () async {
    DioBuilder dioBuilderPlugin = DioBuilder();
    MockDioBuilderPlatform fakePlatform = MockDioBuilderPlatform();
    DioBuilderPlatform.instance = fakePlatform;

    expect(await dioBuilderPlugin.getPlatformVersion(), '42');
  });
}
