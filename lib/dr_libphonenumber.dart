library dr_libphonenumber;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'src/model/phone_number_format.dart';
part 'src/model/phone_number_type.dart';
part 'src/model/region_info.dart';

abstract class DrLibphonenumber {
  @visibleForTesting
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler);

  Future<bool?> isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  });

  Future<String?> normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  });

  Future<RegionInfo> getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  });

  Future<PhoneNumberType> getNumberType({
    required String phoneNumber,
    required String isoCode,
  });

  Future<String?> formatAsYouType({
    required String phoneNumber,
    required String isoCode,
  });

  Future<String?> format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  });

  Future<String?> getRegionCodeForCountryCode(int callingCode);
}
