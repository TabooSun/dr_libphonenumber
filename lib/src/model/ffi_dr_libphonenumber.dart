import 'dart:ffi';
import 'dart:io';

import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber/src/bindings.dart'
    hide PhoneNumberFormat, PhoneNumberType;
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

class FfiDrLibphonenumber extends DrLibphonenumber {
  final DrLibphonenumberBindings nativeLibphonenumber =
      DrLibphonenumberBindings(Platform.isAndroid
          ? (DynamicLibrary.open('libdr_libphonenumber.so')
            // Load the library. Our library is not that large, loading it here
            // should not be having any performance problem.
            ..providesSymbol('')) // Load the dynamic library on Android
          : DynamicLibrary.process());

  @override
  String? format({
    required String phoneNumber,
    required String isoCode,
    PhoneNumberFormat numberFormat = PhoneNumberFormat.rfc3966,
  }) {
    String? formattedPhoneNumber;
    using((Arena arena) {
      final phoneNumberPtr =
          phoneNumber.toNativeUtf8(allocator: arena).cast<Int8>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Int8>();

      final formattedPhoneNumberPtr = arena.using(
        nativeLibphonenumber.format(
          phoneNumberPtr,
          isoCodePtr,
          numberFormat.toDrLibphonenumberNativePhoneNumberFormat(),
        ),
        nativeLibphonenumber.free_c_char,
      );

      formattedPhoneNumber =
          '${formattedPhoneNumberPtr.cast<Utf8>().toDartString()}';
    });

    return formattedPhoneNumber;
  }

  @override
  PhoneNumberType getNumberType({
    required String phoneNumber,
    required String isoCode,
  }) {
    var phoneNumberType = PhoneNumberType.unknown;
    using((Arena arena) {
      final phoneNumberPtr =
          phoneNumber.toNativeUtf8(allocator: arena).cast<Int8>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Int8>();

      phoneNumberType = PhoneNumberTypeHelper.parse(
          nativeLibphonenumber.getNumberType(phoneNumberPtr, isoCodePtr));
    });
    return phoneNumberType;
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
