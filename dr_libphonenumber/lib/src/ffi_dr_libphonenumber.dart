import 'dart:ffi';
import 'dart:io';

import 'package:dr_libphonenumber/src/bindings.dart';
import 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as path;
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

    const flutterTestKey = 'FLUTTER_TEST';
    if (Platform.environment.containsKey(flutterTestKey) &&
        Platform.environment[flutterTestKey] == 'true' &&
        (Platform.isMacOS || Platform.isWindows)) {
      final String libPath = _detectLibraryByDevice();
      if (!File(libPath).existsSync()) {
        throw Exception(
          '$libPath not found. Please make sure that you have built all the Rust targets.',
        );
      }

      return DynamicLibrary.open(libPath);
    }

    return DynamicLibrary.process();
  }

  static String _detectLibraryByDevice() {
    final package = _findPackage();
    final drLibphonenumberPackageDir = _findFlutterProjectRoot(
      relativeTo: Directory(
        path.joinAll([
          package.root.toFilePath(windows: Platform.isWindows),
          // We need to add this entry for this package test module to correctly
          // figure out the artifacts.

          'dr_libphonenumber/',
        ]),
      ),
    );
    if (drLibphonenumberPackageDir == null) {
      throw Exception(
        'dr_libphonenumber is not found in the current project.',
      );
    }
    final drLibphonenumberPackagePath = drLibphonenumberPackageDir.path;
    final artifactsDirParents = [
      drLibphonenumberPackagePath,
      'test/artifacts',
    ];
    if (Platform.isWindows) {
      return path.joinAll([
        ...artifactsDirParents,
        'x86_64-pc-windows-gnu/libdr_libphonenumber.dll',
      ]);
    }

    final appleDarwinArchitecture = Process.runSync('arch', []).stdout;
    if (appleDarwinArchitecture is String &&
        appleDarwinArchitecture.trim() == 'arm64') {
      return path.joinAll([
        ...artifactsDirParents,
        'aarch64-apple-darwin/libdr_libphonenumber.dylib',
      ]);
    }

    return path.joinAll(
      [
        ...artifactsDirParents,
        'x86_64-apple-darwin/libdr_libphonenumber.dylib',
      ],
    );
  }

  static Package _findPackage() {
    final flutterProjectRoot =
        _findFlutterProjectRoot(relativeTo: Directory.current);
    if (flutterProjectRoot == null) {
      throw Exception('Could not find flutter project root.');
    }
    final packageConfigFile = File(
      path.joinAll([
        flutterProjectRoot.path,
        '.dart_tool/package_config.json',
      ]),
    );
    final packageConfigJsonString = packageConfigFile.readAsStringSync();
    final packageConfig = PackageConfig.parseString(
      packageConfigJsonString,
      packageConfigFile.uri,
    );
    return packageConfig.packages
        .firstWhere((x) => x.name == 'dr_libphonenumber');
  }

  static Directory? _findFlutterProjectRoot({
    required Directory relativeTo,
  }) {
    const flutterProjectRootSentinel = 'pubspec.yaml';
    var flutterProjectRoot = relativeTo;
    while (true) {
      if (File(path.join(flutterProjectRoot.path, flutterProjectRootSentinel))
          .existsSync()) {
        break;
      }

      final parent = flutterProjectRoot.parent;
      if (parent.path == flutterProjectRoot.path) {
        return null;
      }
      flutterProjectRoot = parent;
    }

    return flutterProjectRoot;
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
          arena.using<Pointer<MutableLibPhoneNumberResult_c_char>>(
        nativeLibphonenumber.format(
          phoneNumberPtr,
          isoCodePtr,
          numberFormat.toDrLibphonenumberNativePhoneNumberFormat(),
        ),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
      );

      _handleFfiError(formattedPhoneNumberPtr.ref.error);

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

      final result =
          arena.using<Pointer<LibPhoneNumberResult_DrPhoneNumberType>>(
        nativeLibphonenumber.get_number_type(phoneNumberPtr, isoCodePtr),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
      );
      _handleFfiError(result.ref.error);

      phoneNumberType = PhoneNumberTypeHelper.parse(
        result.ref.data,
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
      final regionCodePtr =
          arena.using<Pointer<MutableLibPhoneNumberResult_c_char>>(
        nativeLibphonenumber.get_region_code_for_country_code(callingCode),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
      );
      _handleFfiError(regionCodePtr.ref.error);
      regionCode = regionCodePtr.ref.data.cast<Utf8>().toDartString();
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

      final regionInfoPtr =
          arena.using<Pointer<MutableLibPhoneNumberResult_DrRegionInfo>>(
        nativeLibphonenumber.get_region_info(phoneNumberPtr, isoCodePtr),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
      );
      _handleFfiError(regionInfoPtr.ref.error);

      final drRegionInfo = regionInfoPtr.ref.data.ref;
      regionInfo = RegionInfo(
        regionCode: drRegionInfo.region_code,
        countryCode: drRegionInfo.country_code.cast<Utf8>().toDartString(),
        phoneNumberValue: drRegionInfo.phone_number_value,
        formattedPhoneNumber:
            drRegionInfo.formatted_number.cast<Utf8>().toDartString(),
      );
    });
    return regionInfo;
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

      final result = arena.using<Pointer<LibPhoneNumberResult_bool>>(
        nativeLibphonenumber.is_valid_phone_number(
          phoneNumberPtr,
          isoCodePtr,
        ),
        (ptr) => nativeLibphonenumber.free_memory(ptr.cast<Void>()),
      );
      _handleFfiError(result.ref.error);
      isValidPhoneNumber = result.ref.data;
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

  @override
  void initMockForTesting(Future<dynamic>? Function(MethodCall call)? handler) {
    // DO NOTHING.
    // We should try to archive Desktop version for testing.
  }

  void _handleFfiError(Pointer<Char> error) {
    if (error == nullptr) {
      return;
    }
    final errorValue = error.cast<Utf8>().toDartString();
    if (isBlank(errorValue)) {
      return;
    }

    throw DrLibphonenumberException(errorValue);
  }
}
