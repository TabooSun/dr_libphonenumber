import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dr_libphonenumber_web_platform_interface.dart';

/// An implementation of [DrLibphonenumberWebPlatform] that uses method channels.
class MethodChannelDrLibphonenumberWeb extends DrLibphonenumberWebPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dr_libphonenumber_web');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
