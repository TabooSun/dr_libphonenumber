library libphonenumber_platform_interface;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'src/null_dr_libphonenumber.dart';

part 'src/phone_number_format.dart';

part 'src/phone_number_type.dart';

part 'src/region_info.dart';

abstract class DrLibphonenumberPlatform extends PlatformInterface {
  static final Object _token = Object();

  DrLibphonenumberPlatform() : super(token: _token);

  @visibleForTesting
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler);

  static DrLibphonenumberPlatform _instance = NullDrLibphonenumber();

  static DrLibphonenumberPlatform get instance => _instance;

  static set instance(DrLibphonenumberPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  bool isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  });

  String? normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  });

  RegionInfo? getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  });

  PhoneNumberType getNumberType({
    required String phoneNumber,
    required String isoCode,
  });

  String? format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  });

  String? getRegionCodeForCountryCode(int callingCode);
}
