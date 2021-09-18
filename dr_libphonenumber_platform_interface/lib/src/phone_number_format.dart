part of libphonenumber_platform_interface;

enum PhoneNumberFormat {
  e164,
  international,
  national,
  rfc3966,
}

extension PhoneNumberFormatExt on PhoneNumberFormat {
  int toDrLibphonenumberNativePhoneNumberFormat() => index;
}
