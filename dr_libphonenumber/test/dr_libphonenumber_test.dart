import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

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
            DrLibphonenumber.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              numberFormat: PhoneNumberFormat.e164,
            ),
            '+60129602189',
          );
        },
      );
      test(
        'Format phone number in international format.',
        () {
          expect(
            DrLibphonenumber.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              numberFormat: PhoneNumberFormat.international,
            ),
            '+60 12-960 2189',
          );
        },
      );
      test(
        'Format phone number in international format.',
        () {
          expect(
            DrLibphonenumber.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              numberFormat: PhoneNumberFormat.national,
            ),
            '012-960 2189',
          );
        },
      );
      test(
        'Format phone number in international format.',
        () {
          expect(
            DrLibphonenumber.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode,
              numberFormat: PhoneNumberFormat.rfc3966,
            ),
            'tel:+60-12-960-2189',
          );
        },
      );
      test(
        'Format phone number with lowercase iso code.',
        () {
          expect(
            DrLibphonenumber.format(
              phoneNumber: phoneNumber,
              isoCode: isoCode.toLowerCase(),
              numberFormat: PhoneNumberFormat.international,
            ),
            '+60 12-960 2189',
          );
        },
      );
      test(
        'Format invalid phone number in e164 format.',
        () {
          expect(
            () => DrLibphonenumber.format(
              phoneNumber: '0',
              isoCode: isoCode,
              numberFormat: PhoneNumberFormat.e164,
            ),
            throwsA(isA<DrLibphonenumberException>()),
          );
        },
      );
    },
  );

  test(
    'Get number type from phone number and iso code.',
    () {
      expect(
        DrLibphonenumber.getNumberType(
          phoneNumber: phoneNumber,
          isoCode: isoCode.toLowerCase(),
        ),
        PhoneNumberType.mobile,
      );
    },
  );
  test(
    'Get region code from country code.',
    () {
      expect(
        DrLibphonenumber.getRegionCodeForCountryCode(60),
        isoCode,
      );
    },
  );
  test(
    'Get region info from phone number and iso code.',
    () {
      expect(
        DrLibphonenumber.getRegionInfo(
          phoneNumber: phoneNumber,
          isoCode: isoCode,
        ),
        RegionInfo(
          regionCode: 60,
          countryCode: isoCode,
          phoneNumberValue: 129602189,
          formattedPhoneNumber: '012-960 2189',
        ),
      );
    },
  );
}
