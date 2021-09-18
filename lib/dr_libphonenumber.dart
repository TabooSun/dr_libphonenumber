library dr_libphonenumber;

import 'dart:async';

import 'package:dr_libphonenumber/src/model/ffi_dr_libphonenumber.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'src/model/phone_number_format.dart';
part 'src/model/phone_number_type.dart';
part 'src/model/region_info.dart';

abstract class DrLibphonenumber {
  @visibleForTesting
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler);

  static final DrLibphonenumber instance = FfiDrLibphonenumber();

  bool isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  });

  String? normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  });

  RegionInfo? getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  });

  PhoneNumberType getNumberType({
    required String phoneNumber,
    required String isoCode,
  });

  String? format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  });

  String? getRegionCodeForCountryCode(int callingCode);
}
