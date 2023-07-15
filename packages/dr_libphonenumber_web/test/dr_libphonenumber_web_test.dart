import 'package:flutter_test/flutter_test.dart';
import 'package:dr_libphonenumber_web/dr_libphonenumber_web.dart';
import 'package:dr_libphonenumber_web/dr_libphonenumber_web_platform_interface.dart';
import 'package:dr_libphonenumber_web/dr_libphonenumber_web_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDrLibphonenumberWebPlatform
    with MockPlatformInterfaceMixin
    implements DrLibphonenumberWebPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DrLibphonenumberWebPlatform initialPlatform = DrLibphonenumberWebPlatform.instance;

  test('$MethodChannelDrLibphonenumberWeb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDrLibphonenumberWeb>());
  });

  test('getPlatformVersion', () async {
    DrLibphonenumberWeb drLibphonenumberWebPlugin = DrLibphonenumberWeb();
    MockDrLibphonenumberWebPlatform fakePlatform = MockDrLibphonenumberWebPlatform();
    DrLibphonenumberWebPlatform.instance = fakePlatform;

    expect(await drLibphonenumberWebPlugin.getPlatformVersion(), '42');
  });
}
