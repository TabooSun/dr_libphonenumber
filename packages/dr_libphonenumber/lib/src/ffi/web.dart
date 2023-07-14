import 'package:dr_libphonenumber/src/bridge_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

typedef ExternalLibrary = WasmModule;

DrLibphonenumber createWrapperImpl(ExternalLibrary module) {
// Path to the wasm_bindgen generated files
  const root = 'pkg/native';
  return DrLibphonenumberImpl.wasm(WasmModule.initialize(
    kind: const Modules.noModules(root: root),
  ));
}