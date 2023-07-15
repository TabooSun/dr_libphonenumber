import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dr_libphonenumber_web_method_channel.dart';

abstract class DrLibphonenumberWebPlatform extends PlatformInterface {
  /// Constructs a DrLibphonenumberWebPlatform.
  DrLibphonenumberWebPlatform() : super(token: _token);

  static final Object _token = Object();

  static DrLibphonenumberWebPlatform _instance = MethodChannelDrLibphonenumberWeb();

  /// The default instance of [DrLibphonenumberWebPlatform] to use.
  ///
  /// Defaults to [MethodChannelDrLibphonenumberWeb].
  static DrLibphonenumberWebPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DrLibphonenumberWebPlatform] when
  /// they register themselves.
  static set instance(DrLibphonenumberWebPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
