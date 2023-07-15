import 'dart:async';

import 'package:dr_libphonenumber/src/bridge_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

typedef ExternalLibrary = FutureOr<WasmModule>;

DrLibphonenumber createWrapperImpl(ExternalLibrary module) {
  return DrLibphonenumberImpl.wasm(module);
}

FutureOr<WasmModule> createLibraryImpl() {
  // Path to the wasm_bindgen generated files
  const root = 'pkg/dr_libphonenumber';
  return WasmModule.initialize(
    kind: const Modules.noModules(root: root),
  );
}
