import 'dart:ffi';
import 'dart:io';

import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber/src/bindings.dart' hide PhoneNumberFormat;
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

class FfiDrLibphonenumber extends DrLibphonenumber {
  final DrLibphonenumberBindings nativeLibphonenumber =
      DrLibphonenumberBindings(Platform.isAndroid
          ? DynamicLibrary.open(
              'libdr_libphonenumber.so') // Load the dynamic library on Android
          : DynamicLibrary.process());

  @override
  String? format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  }) {
    final phoneNumberPtr = phoneNumber.toNativeUtf8().cast<Int8>();
    final isoCodePtr = isoCode.toNativeUtf8().cast<Int8>();
    final formattedPhoneNumberPtr = nativeLibphonenumber.format(
      phoneNumberPtr,
      isoCodePtr,
      numberFormat.toDrLibphonenumberNativePhoneNumberFormat(),
    );

    final formattedPhoneNumber =
        formattedPhoneNumberPtr.cast<Utf8>().toDartString();

    nativeLibphonenumber.free_c_char(formattedPhoneNumberPtr);

    return formattedPhoneNumber;
  }

  @override
  Future<String?> formatAsYouType({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement formatAsYouType
    throw UnimplementedError();
  }

  @override
  Future<PhoneNumberType> getNumberType({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement getNumberType
    throw UnimplementedError();
  }

  @override
  Future<String?> getRegionCodeForCountryCode(
    int callingCode,
  ) {
    // TODO: implement getRegionCodeForCountryCode
    throw UnimplementedError();
  }

  @override
  Future<RegionInfo> getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement getRegionInfo
    throw UnimplementedError();
  }

  @override
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    // DO NOTHING.
  }

  @override
  Future<bool?> isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement isValidPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<String?> normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    // TODO: implement normalizePhoneNumber
    throw UnimplementedError();
  }
}
