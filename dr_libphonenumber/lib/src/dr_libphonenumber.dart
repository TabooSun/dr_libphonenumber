part of dr_libphonenumber;

class DrLibphonenumber {
  @visibleForTesting
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    // ignore: invalid_use_of_visible_for_testing_member
    _drLibphonenumberPlatform.initMockForTesting(handler);
  }

  static final DrLibphonenumberPlatform _drLibphonenumberPlatform =
      _constructDrLibphonenumberPlatform();

  static DrLibphonenumberPlatform _constructDrLibphonenumberPlatform() {
    if (!kIsWeb) {
      DrLibphonenumberPlatform.instance = FfiDrLibphonenumber();
    }
    return DrLibphonenumberPlatform.instance;
  }

  static bool isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) =>
      _drLibphonenumberPlatform.isValidPhoneNumber(
        phoneNumber: phoneNumber,
        isoCode: isoCode,
      );

  static String? normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) =>
      _drLibphonenumberPlatform.normalizePhoneNumber(
        phoneNumber: phoneNumber,
        isoCode: isoCode,
      );

  static RegionInfo? getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  }) =>
      _drLibphonenumberPlatform.getRegionInfo(
        phoneNumber: phoneNumber,
        isoCode: isoCode,
      );

  static PhoneNumberType getNumberType({
    required String phoneNumber,
    required String isoCode,
  }) =>
      _drLibphonenumberPlatform.getNumberType(
        phoneNumber: phoneNumber,
        isoCode: isoCode,
      );

  static String? format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  }) =>
      _drLibphonenumberPlatform.format(
        phoneNumber: phoneNumber,
        isoCode: isoCode,
        numberFormat: numberFormat,
      );

  static String? getRegionCodeForCountryCode(int callingCode) =>
      _drLibphonenumberPlatform.getRegionCodeForCountryCode(callingCode);
}
