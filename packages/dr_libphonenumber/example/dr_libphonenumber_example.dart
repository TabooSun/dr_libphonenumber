import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber/src/bridge_generated.dart';

void main() {
  var lib = LibPhoneNumber.i;
  print(
    'awesome: ${lib.format(
      phoneNumber: '0123456789',
      isoCode: 'my',
      phoneNumberFormat: DrPhoneNumberFormat.e164,
    )}',
  );
}
