import 'dart:ffi';
import 'dart:io';

import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber/src/bindings.dart'
    hide PhoneNumberFormat, PhoneNumberType, RegionInfo;
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

class FfiDrLibphonenumber extends DrLibphonenumber {
  final DrLibphonenumberBindings nativeLibphonenumber =
      DrLibphonenumberBindings(_constructDynamicLibrary());

  static DynamicLibrary _constructDynamicLibrary() {
    if (Platform.isAndroid) {
      return DynamicLibrary.open('libdr_libphonenumber.so')
        // Load the library. Our library is not that large, loading it here
        // should not be having any performance problem.
        ..providesSymbol('');
    }

    if (Platform.isMacOS) {
      const libPath =
          'native/dr_libphonenumber/target/x86_64-apple-darwin/release/libdr_libphonenumber.dylib';
      if (!File(libPath).existsSync()) {
        throw Exception('$libPath not found.');
      }

      return DynamicLibrary.open(libPath);
    }

    return DynamicLibrary.process();
  }

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
        nativeLibphonenumber.freeCChar,
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
  String? getRegionCodeForCountryCode(
    int callingCode,
  ) {
    String? regionCode;
    using((Arena arena) {
      final regionCodePtr = arena.using(
        nativeLibphonenumber.getRegionCodeForCountryCode(callingCode),
        nativeLibphonenumber.freeCChar,
      );
      regionCode = '${regionCodePtr.cast<Utf8>().toDartString()}';
    });
    return regionCode;
  }

  @override
  RegionInfo? getRegionInfo({
    required String phoneNumber,
    required String isoCode,
  }) {
    RegionInfo? regionInfo;
    using((Arena arena) {
      final phoneNumberPtr =
          phoneNumber.toNativeUtf8(allocator: arena).cast<Int8>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Int8>();

      final regionInfoPtr = arena.using(
        nativeLibphonenumber.getRegionInfo(phoneNumberPtr, isoCodePtr),
        nativeLibphonenumber.freeRegionInfo,
      );

      regionInfo = RegionInfo(
        regionCode: regionInfoPtr.ref.regionCode,
        countryCode: regionInfoPtr.ref.countryCode.cast<Utf8>().toDartString(),
        phoneNumberValue: regionInfoPtr.ref.phoneNumberValue,
        formattedPhoneNumber:
            regionInfoPtr.ref.formattedNumber.cast<Utf8>().toDartString(),
      );
    });
    return regionInfo;
  }

  @override
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    // DO NOTHING.
    // We should try to archive Desktop version for testing.
  }

  @override
  bool isValidPhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    var isValidPhoneNumber = false;
    using((Arena arena) {
      final phoneNumberPtr =
          phoneNumber.toNativeUtf8(allocator: arena).cast<Int8>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Int8>();

      isValidPhoneNumber =
          nativeLibphonenumber.isValidPhoneNumber(phoneNumberPtr, isoCodePtr) ==
              1;
    });
    return isValidPhoneNumber;
  }

  @override
  String? normalizePhoneNumber({
    required String phoneNumber,
    required String isoCode,
  }) {
    return format(
      phoneNumber: phoneNumber,
      isoCode: isoCode,
      numberFormat: PhoneNumberFormat.e164,
    );
  }
}
