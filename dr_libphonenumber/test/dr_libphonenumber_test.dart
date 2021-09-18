import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DrLibphonenumber.instance.toString();
  const phoneNumber = '0129602189';
  const isoCode = 'MY';
  group('Format phone number', () {
    test(
      'Format phone number in e164 format.',
      () {
        expect(
          DrLibphonenumber.instance.format(
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
          DrLibphonenumber.instance.format(
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
          DrLibphonenumber.instance.format(
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
          DrLibphonenumber.instance.format(
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
          DrLibphonenumber.instance.format(
            phoneNumber: phoneNumber,
            isoCode: isoCode.toLowerCase(),
            numberFormat: PhoneNumberFormat.international,
          ),
          '+60 12-960 2189',
        );
      },
    );
  });
  
  test(
    'Get number type from phone number and iso code.',
    () {
      expect(
        DrLibphonenumber.instance.getNumberType(
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
        DrLibphonenumber.instance.getRegionCodeForCountryCode(60),
        isoCode,
      );
    },
  );
  test(
    'Get region info from phone number and iso code.',
    () {
      expect(
        DrLibphonenumber.instance.getRegionInfo(
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
