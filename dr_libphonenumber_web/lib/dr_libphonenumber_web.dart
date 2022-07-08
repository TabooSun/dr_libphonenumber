import 'dart:async';

import 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart';
import 'package:dr_libphonenumber_web/src/libphonenumber_js.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the DrLibphonenumber plugin.
class DrLibphonenumberWeb extends DrLibphonenumberPlatform {
  static void registerWith(Registrar registrar) {
    DrLibphonenumberPlatform.instance = DrLibphonenumberWeb();
  }

  PhoneNumberUtil? _phoneNumberUtil;

  PhoneNumberUtil get phoneNumberUtil =>
      _phoneNumberUtil ??= PhoneNumberUtil.getInstance();

  @override
  String? format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  }) {
    try {
      return phoneNumberUtil.format(
            phoneNumberUtil.parse(phoneNumber, isoCode.toUpperCase()),
            numberFormat.index,
          );
    } catch (e) {
      throw DrLibphonenumberException(e.toString());
    }
  }

  @override
  PhoneNumberType getNumberType({
    required String phoneNumber,
    required String isoCode,
  }) {
    try {
      return PhoneNumberType.values[phoneNumberUtil.getNumberType(
            phoneNumberUtil.parse(phoneNumber, isoCode.toUpperCase()),
            isoCode,
          )];
    } catch (e) {
      throw DrLibphonenumberException(e.toString());
    }
  }

  @override
  String? getRegionCodeForCountryCode(int callingCode) {
    try {
      return phoneNumberUtil.getRegionCodeForCountryCode(callingCode);
    } catch (e) {
      throw DrLibphonenumberException(e.toString());
    }
  }

  @override
  RegionInfo? getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  }) {
    try {
      final telNumber = phoneNumberUtil.parse(phoneNumber, isoCode.toUpperCase());

      return RegionInfo(
            formattedPhoneNumber:
                phoneNumberUtil.format(telNumber, PhoneNumberFormat.national.index),
            phoneNumberValue: telNumber.getNationalNumber(),
            countryCode: phoneNumberUtil.getRegionCodeForNumber(telNumber),
            regionCode: telNumber.getCountryCode(),
          );
    } catch (e) {
      throw DrLibphonenumberException(e.toString());
    }
  }

  @override
  bool isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    try {
      return phoneNumberUtil.isValidNumber(
            phoneNumberUtil.parse(
              phoneNumber,
              isoCode.toUpperCase(),
            ),
          );
    } catch (e) {
      throw DrLibphonenumberException(e.toString());
    }
  }

  @override
  String? normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    try {
      return format(
            phoneNumber: phoneNumber,
            isoCode: isoCode,
            numberFormat: PhoneNumberFormat.e164,
          );
    } catch (e) {
      throw DrLibphonenumberException(e.toString());
    }
  }

  @override
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    // DO NOTHING
  }
}
