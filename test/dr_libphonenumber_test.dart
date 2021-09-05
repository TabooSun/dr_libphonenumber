import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dr_libphonenumber/dr_libphonenumber.dart';

void main() {
  const channel = MethodChannel('dr_libphonenumber');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {

  });
}
