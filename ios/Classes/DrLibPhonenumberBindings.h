
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

char *format(const char *phoneNumber,
             const char *isoCode,
             enum PhoneNumberFormat phoneNumberFormat);

void free_c_char(char *str);
