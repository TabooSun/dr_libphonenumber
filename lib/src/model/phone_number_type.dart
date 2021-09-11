part of dr_libphonenumber;

enum PhoneNumberType {
  fixedLine,
  mobile,
  fixedLineOrMobile,
  tollFree,
  premiumRate,
  sharedCost,
  personalNumber,
  voip,
  pager,
  uan,
  emergency,
  voicemail,
  shortCode,
  standardRate,
  carrier,
  noInternational,
  unknown
}

extension PhoneNumberTypeExt on PhoneNumberType {
  int toDrLibphonenumberNativePhoneNumberType() => index;
}

class PhoneNumberTypeHelper {
  static PhoneNumberType parse(int type) {
    return PhoneNumberType.values[type];
  }
}
