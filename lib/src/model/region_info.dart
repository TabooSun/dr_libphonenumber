part of dr_libphonenumber;

/// Check https://countrycode.org/ for detail.
class RegionInfo {
  /// The region code or calling code.
  final int regionCode;

  /// The phone number excluding the [regionCode].
  final int phoneNumberValue;

  /// The country code.
  final String? countryCode;

  /// The formatted phone number with combination of [regionCode] & [phoneNumberValue].
  final String? formattedPhoneNumber;

  RegionInfo({
    this.regionCode = 0,
    this.phoneNumberValue = 0,
    this.countryCode,
    this.formattedPhoneNumber,
  });

  @override
  String toString() {
    return '[RegionInfo prefix=$regionCode, phoneNumberValue=$phoneNumberValue, iso=$countryCode, formatted=$formattedPhoneNumber]';
  }
}
