import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber/src/bridge_generated.dart';
import 'package:dr_libphonenumber/src/ffi.dart';

class LibPhoneNumber {
  static final DrLibphonenumber i = createLib();

  LibPhoneNumber._();
}
