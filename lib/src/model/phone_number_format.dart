part of dr_libphonenumber;

enum PhoneNumberFormat {
  e164,
  international,
  national,
  rfc3966,
}

extension PhoneNumberFormatExt on PhoneNumberFormat {
  int toDrLibphonenumberNativePhoneNumberFormat() => index;
}
