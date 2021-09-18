import 'dart:async';

import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber/src/libphonenumber_js.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the DrLibphonenumber plugin.
class DrLibphonenumberWeb extends DrLibphonenumber {
  static void registerWith(Registrar registrar) {
    final channel = MethodChannel(
      'dr_libphonenumber',
      const StandardMethodCodec(),
      registrar,
    );
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
    return phoneNumberUtil.format(
      phoneNumberUtil.parse(phoneNumber, isoCode.toUpperCase()),
      numberFormat.index,
    );
  }

  @override
  PhoneNumberType getNumberType(
      {required String phoneNumber, required String isoCode}) {
    return PhoneNumberType.values[phoneNumberUtil.getNumberType(
      phoneNumberUtil.parse(phoneNumber, isoCode.toUpperCase()),
      isoCode,
    )];
  }

  @override
  String? getRegionCodeForCountryCode(int callingCode) {
    return phoneNumberUtil.getRegionCodeForCountryCode(callingCode);
  }

  @override
  RegionInfo? getRegionInfo(
      {required String phoneNumber, required String isoCode}) {
    final telNumber = phoneNumberUtil.parse(phoneNumber, isoCode.toUpperCase());

    return RegionInfo(
      formattedPhoneNumber:
          phoneNumberUtil.format(telNumber, PhoneNumberFormat.national.index),
      phoneNumberValue: telNumber.getNationalNumber(),
      countryCode: phoneNumberUtil.getRegionCodeForNumber(telNumber),
      regionCode: telNumber.getCountryCode(),
    );
  }

  @override
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    // DO NOTHING
  }

  @override
  bool isValidPhoneNumber(
      {required String phoneNumber, required String isoCode}) {
    // TODO: implement isValidPhoneNumber
    throw UnimplementedError();
  }

  @override
  String? normalizePhoneNumber(
      {required String phoneNumber, required String isoCode}) {
    // TODO: implement normalizePhoneNumber
    throw UnimplementedError();
  }
}
