import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:test/test.dart';

void main() {
  const phoneNumber = '0129602189';
  const isoCode = 'MY';
  group(
    'Format phone number',
    () {
      test(
        'Format phone number in e164 format.',
        () {
          expect(
            LibPhoneNumber.i.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              phoneNumberFormat: DrPhoneNumberFormat.e164,
            ),
            '+60129602189',
          );
        },
      );
      test(
        'Format phone number in international format.',
        () {
          expect(
            LibPhoneNumber.i.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              phoneNumberFormat: DrPhoneNumberFormat.international,
            ),
            '+60 12-960 2189',
          );
        },
      );
      test(
        'Format phone number in international format.',
        () {
          expect(
            LibPhoneNumber.i.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              phoneNumberFormat: DrPhoneNumberFormat.national,
            ),
            '012-960 2189',
          );
        },
      );
      test(
        'Format phone number in international format.',
        () {
          expect(
            LibPhoneNumber.i.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              phoneNumberFormat: DrPhoneNumberFormat.rfc3966,
            ),
            'tel:+60-12-960-2189',
          );
        },
      );
      test(
        'Format phone number with lowercase iso code.',
        () {
          expect(
            LibPhoneNumber.i.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode.toLowerCase(),
              phoneNumberFormat: DrPhoneNumberFormat.international,
            ),
            '+60 12-960 2189',
          );
        },
      );
      test(
        'Format invalid phone number in e164 format.',
        () {
          expect(
            () => LibPhoneNumber.i.format(
              phoneNumber: '0',
              isoCode: isoCode,
              phoneNumberFormat: DrPhoneNumberFormat.e164,
            ),
            throwsA(isA<FfiException>()),
          );
        },
      );
    },
  );

  test(
    'Get number type from phone number and iso code.',
    () {
      expect(
        LibPhoneNumber.i.getNumberType(
          phoneNumber: phoneNumber,
          isoCode: isoCode.toLowerCase(),
        ),
        DrPhoneNumberType.mobile,
      );
    },
  );
  test(
    'Get region code from country code.',
    () {
      expect(
        LibPhoneNumber.i.getRegionCodeForCountryCode(
          callingCode: 60,
        ),
        isoCode,
      );
    },
  );
  test(
    'Get region info from phone number and iso code.',
    () {
      expect(
        LibPhoneNumber.i.getRegionInfo(
          phoneNumber: phoneNumber,
          isoCode: isoCode,
        ),
        const DrRegionInfo(
          regionCode: 60,
          countryCode: isoCode,
          phoneNumberValue: 129602189,
          formattedPhoneNumber: '012-960 2189',
        ),
      );
    },
  );
}
