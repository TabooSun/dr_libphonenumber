import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dr_libphonenumber_web/dr_libphonenumber_web_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDrLibphonenumberWeb platform = MethodChannelDrLibphonenumberWeb();
  const MethodChannel channel = MethodChannel('dr_libphonenumber_web');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
