import 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart';
import 'package:flutter/services.dart';

class FfiDrLibphonenumber extends DrLibphonenumberPlatform {
  @override
  String? format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  }) {
    throw UnimplementedError();
  }

  @override
  PhoneNumberType getNumberType({
    required String phoneNumber,
    required String isoCode,
  }) {
    throw UnimplementedError();
  }

  @override
  String? getRegionCodeForCountryCode(int callingCode) {
    throw UnimplementedError();
  }

  @override
  RegionInfo? getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  }) {
    throw UnimplementedError();
  }

  @override
  void initMockForTesting(Future? Function(MethodCall call)? handler) {
    // TODO: implement initMockForTesting
  }

  @override
  bool isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    throw UnimplementedError();
  }

  @override
  String? normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    throw UnimplementedError();
  }
}
