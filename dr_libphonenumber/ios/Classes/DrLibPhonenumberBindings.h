#include <stdint.h>

typedef enum PhoneNumberFormat {
  /**
   * E.164 formatting, no spaces, no decorations.
   */
  E164,
  /**
   * International formatting, contains country code and country dependent
   * formatting.
   */
  International,
  /**
   * National formatting, no country code and country dependent formatting.
   */
  National,
  /**
   * RFC3966 formatting, see the RFC.
   */
  Rfc3966,
} PhoneNumberFormat;

typedef enum PhoneNumberType {
  /**
   *
   */
  FixedLine,
  /**
   *
   */
  Mobile,
  /**
   * In some regions (e.g. the USA), it is impossible to distinguish between
   * fixed-line and mobile numbers by looking at the phone number itself.
   */
  FixedLineOrMobile,
  /**
   * Freephone lines.
   */
  TollFree,
  /**
   *
   */
  PremiumRate,
  /**
   * The cost of this call is shared between the caller and the recipient, and
   * is hence typically less than PREMIUM_RATE calls. See
   * http://en.wikipedia.org/wiki/Shared_Cost_Service for more information.
   */
  SharedCost,
  /**
   * A personal number is associated with a particular person, and may be
   * routed to either a MOBILE or FIXED_LINE number. Some more information can
   * be found here: http://en.wikipedia.org/wiki/Personal_Numbers
   */
  PersonalNumber,
  /**
   * Voice over IP numbers. This includes TSoIP (Telephony Service over IP).
   */
  Voip,
  /**
   *
   */
  Pager,
  /**
   * Used for "Universal Access Numbers" or "Company Numbers". They may be
   * further routed to specific offices, but allow one number to be used for a
   * company.
   */
  Uan,
  /**
   *
   */
  Emergency,
  /**
   * Used for "Voice Mail Access Numbers".
   */
  Voicemail,
  /**
   *
   */
  ShortCode,
  /**
   *
   */
  StandardRate,
  /**
   *
   */
  Carrier,
  /**
   *
   */
  NoInternational,
  /**
   * A phone number is of type UNKNOWN when it does not fit any of the known
   * patterns for a specific region.
   */
  Unknown,
} PhoneNumberType;

typedef struct LibPhoneNumberResult_c_char {
  char *data;
  char *error;
} LibPhoneNumberResult_c_char;

/**
 * Check https://countrycode.org/ for detail.
 */
typedef struct RegionInfo {
  /**
   * The region code or calling code.
   */
  uint16_t regionCode;
  /**
   * The phone number excluding the [region_code].
   */
  uint64_t phoneNumberValue;
  /**
   * The country code.
   */
  char *countryCode;
  /**
   * The formatted phone number with combination of [region_code] & [phone_number_value].
   */
  char *formattedNumber;
} RegionInfo;

/**
 * Format the [phone_number] using the [phone_number_format].
 */
struct LibPhoneNumberResult_c_char *format(const char *phoneNumber,
                                           const char *isoCode,
                                           enum PhoneNumberFormat phoneNumberFormat);

enum PhoneNumberType get_number_type(const char *phoneNumber, const char *isoCode);

char *getRegionCodeForCountryCode(uint16_t callingCode);

struct RegionInfo *getRegionInfo(const char *phoneNumber, const char *isoCode);

bool isValidPhoneNumber(const char *phoneNumber, const char *isoCode);

void free_memory(void *unsafeStruct);
