import 'package:dr_libphonenumber/src/bridge_generated.dart';

/// Represents the external library for dr_libphonenumber
///
/// Will be a DynamicLibrary for dart:io or WasmModule for dart:html
typedef ExternalLibrary = Object;

DrLibphonenumber createWrapperImpl(ExternalLibrary lib) =>
    throw UnimplementedError();

Object createLibraryImpl() => throw UnimplementedError();