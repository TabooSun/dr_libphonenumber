part of libphonenumber_platform_interface;

/// Check https://countrycode.org/ for detail.
class RegionInfo with EquatableMixin {
  /// The region code or calling code.
  final int regionCode;

  /// The phone number excluding the [regionCode].
  final int phoneNumberValue;

  /// The country code.
  final String? countryCode;

  /// The formatted phone number with combination of [regionCode] & [phoneNumberValue].
  final String? formattedPhoneNumber;

  @override
  List<Object?> get props => [
        regionCode,
        phoneNumberValue,
        countryCode,
        formattedPhoneNumber,
      ];

  @override
  bool? get stringify => true;

  RegionInfo({
    this.regionCode = 0,
    this.phoneNumberValue = 0,
    this.countryCode,
    this.formattedPhoneNumber,
  });
}
