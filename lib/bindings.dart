// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Dart bindings to call DrLibphonenumber functions
class DrLibphonenumberBindings {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  DrLibphonenumberBindings(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  DrLibphonenumberBindings.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  /// We will call this stub function to prevent iOS from skipping the bundling of this library.
  void stub() {
    return _stub();
  }

  late final _stub_ptr = _lookup<ffi.NativeFunction<_c_stub>>('stub');
  late final _dart_stub _stub = _stub_ptr.asFunction<_dart_stub>();

  ffi.Pointer<ffi.Int8> format(
    ffi.Pointer<ffi.Int8> phone_number,
    ffi.Pointer<ffi.Int8> iso_code,
    int phone_number_format,
  ) {
    return _format(
      phone_number,
      iso_code,
      phone_number_format,
    );
  }

  late final _format_ptr = _lookup<ffi.NativeFunction<_c_format>>('format');
  late final _dart_format _format = _format_ptr.asFunction<_dart_format>();

  void free_c_char(
    ffi.Pointer<ffi.Int8> str,
  ) {
    return _free_c_char(
      str,
    );
  }

  late final _free_c_char_ptr =
      _lookup<ffi.NativeFunction<_c_free_c_char>>('free_c_char');
  late final _dart_free_c_char _free_c_char =
      _free_c_char_ptr.asFunction<_dart_free_c_char>();
}

abstract class PhoneNumberFormat {
  /// E.164 formatting, no spaces, no decorations.
  static const int E164 = 0;

  /// International formatting, contains country code and country dependent
  /// formatting.
  static const int International = 1;

  /// National formatting, no country code and country dependent formatting.
  static const int National = 2;

  /// RFC3966 formatting, see the RFC.
  static const int Rfc3966 = 3;
}

typedef _c_stub = ffi.Void Function();

typedef _dart_stub = void Function();

typedef _c_format = ffi.Pointer<ffi.Int8> Function(
  ffi.Pointer<ffi.Int8> phone_number,
  ffi.Pointer<ffi.Int8> iso_code,
  ffi.Int32 phone_number_format,
);

typedef _dart_format = ffi.Pointer<ffi.Int8> Function(
  ffi.Pointer<ffi.Int8> phone_number,
  ffi.Pointer<ffi.Int8> iso_code,
  int phone_number_format,
);

typedef _c_free_c_char = ffi.Void Function(
  ffi.Pointer<ffi.Int8> str,
);

typedef _dart_free_c_char = void Function(
  ffi.Pointer<ffi.Int8> str,
);
