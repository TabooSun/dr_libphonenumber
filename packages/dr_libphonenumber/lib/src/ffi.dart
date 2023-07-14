import 'bridge_generated.dart';
import 'ffi/stub.dart'
    if (dart.library.io) 'ffi/io.dart'
    if (dart.library.html) 'ffi/web.dart';

DrLibphonenumber? _wrapper;

DrLibphonenumber createWrapper(ExternalLibrary lib) {
  _wrapper ??= createWrapperImpl(lib);
  return _wrapper!;
}

DrLibphonenumber createLib() =>
    createWrapper(createLibraryImpl());