part of dr_libphonenumber;

class RegionInfo {
  String? regionPrefix;
  String? isoCode;
  String? formattedPhoneNumber;

  RegionInfo({
    this.regionPrefix,
    this.isoCode,
    this.formattedPhoneNumber,
  });

  @override
  String toString() {
    return '[RegionInfo prefix=$regionPrefix, iso=$isoCode, formatted=$formattedPhoneNumber]';
  }
}
