import 'dart:ffi';
import 'dart:io';

import 'package:dr_libphonenumber/src/bindings.dart'
    hide PhoneNumberFormat, PhoneNumberType, RegionInfo;
import 'package:dr_libphonenumber/src/bindings.dart' as bindings
    show RegionInfo;
import 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:quiver/strings.dart';

class FfiDrLibphonenumber extends DrLibphonenumberPlatform {
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
          phoneNumber.toNativeUtf8(allocator: arena).cast<Char>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Char>();

      final formattedPhoneNumberPtr =
          arena.using<Pointer<LibPhoneNumberResult_c_char>>(
        nativeLibphonenumber.format(
          phoneNumberPtr,
          isoCodePtr,
          numberFormat.toDrLibphonenumberNativePhoneNumberFormat(),
        ),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
      );

      final errorValue = formattedPhoneNumberPtr.ref.error.cast<Utf8>().toDartString();
      if (isNotBlank(errorValue)) {
        throw DrLibphonenumberException(errorValue);
      }

      formattedPhoneNumber =
          formattedPhoneNumberPtr.ref.data.cast<Utf8>().toDartString();
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
          phoneNumber.toNativeUtf8(allocator: arena).cast<Char>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Char>();

      phoneNumberType = PhoneNumberTypeHelper.parse(
        nativeLibphonenumber.get_number_type(phoneNumberPtr, isoCodePtr),
      );
    });
    return phoneNumberType;
  }

  @override
  String? getRegionCodeForCountryCode(
    int callingCode,
  ) {
    String? regionCode;
    using((Arena arena) {
      final regionCodePtr = arena.using<Pointer<Char>>(
        nativeLibphonenumber.getRegionCodeForCountryCode(callingCode),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
      );
      regionCode = regionCodePtr.cast<Utf8>().toDartString();
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
          phoneNumber.toNativeUtf8(allocator: arena).cast<Char>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Char>();

      final regionInfoPtr = arena.using<Pointer<bindings.RegionInfo>>(
        nativeLibphonenumber.getRegionInfo(phoneNumberPtr, isoCodePtr),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
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
          phoneNumber.toNativeUtf8(allocator: arena).cast<Char>();
      final isoCodePtr = isoCode.toNativeUtf8(allocator: arena).cast<Char>();

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
