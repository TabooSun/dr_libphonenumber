part of libphonenumber_platform_interface;

class NullDrLibphonenumber extends DrLibphonenumberPlatform {
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
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    // DO NOTHING
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
