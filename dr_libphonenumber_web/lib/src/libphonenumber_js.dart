@JS()
library libphonenumber;

import 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart';
import 'package:js/js.dart';

@JS('libphonenumber.PhoneNumberUtil')
class PhoneNumberUtil {
  @JS()
  external static PhoneNumberUtil getInstance();

  @JS()
  external List<String> getSupportedRegions();

  /// Parse the phone number.
  ///
  /// - [phoneNumber] - The phone number to be formatted.
  /// - [isoCode] - The country code. e.g. MY.
  @JS()
  external PhoneNumber parse(String phoneNumber, String isoCode);

  /// Format the phone number.
  ///
  /// - [phoneNumber] - The phone number to be formatted.
  /// - [phoneNumberFormat] - Use the [PhoneNumberFormat.index].
  @JS()
  external String format(PhoneNumber phoneNumber, int phoneNumberFormat);

  /// Get number type of [phoneNumber].
  ///
  /// - Return: [PhoneNumberType.index].
  @JS()
  external int getNumberType(PhoneNumber phoneNumber, String isoCode);

  @JS()
  external String getRegionCodeForCountryCode(int callingCode);

  @JS()
  external String getRegionCodeForNumber(PhoneNumber phoneNumber);

  @JS()
  external bool isValidNumber(PhoneNumber phoneNumber);
}

@JS('libphonenumber.PhoneNumber')
class PhoneNumber {
  @JS()
  external int getCountryCode();

  @JS()
  external int getNationalNumber();
}

@JS()
class AsYouTypeFormatter {
  @JS()
  external String inputDigit(String digit);
}
