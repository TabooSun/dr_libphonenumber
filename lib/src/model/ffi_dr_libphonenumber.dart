import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber/src/model/platform_channel.dart';
import 'package:flutter/services.dart';

class FfiDrLibphonenumber extends DrLibphonenumber {
  static const MethodChannel _channel =
      const MethodChannel(PlatformChannel.methodChannelName);

  @override
  Future<String?> format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  }) {
    // TODO: implement format
    throw UnimplementedError();
  }

  @override
  Future<String?> formatAsYouType({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement formatAsYouType
    throw UnimplementedError();
  }

  @override
  Future<PhoneNumberType> getNumberType({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement getNumberType
    throw UnimplementedError();
  }

  @override
  Future<String?> getRegionCodeForCountryCode(
    int callingCode,
  ) {
    // TODO: implement getRegionCodeForCountryCode
    throw UnimplementedError();
  }

  @override
  Future<RegionInfo> getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement getRegionInfo
    throw UnimplementedError();
  }

  @override
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    _channel.setMockMethodCallHandler(handler);
  }

  @override
  Future<bool?> isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement isValidPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<String?> normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement normalizePhoneNumber
    throw UnimplementedError();
  }
}
