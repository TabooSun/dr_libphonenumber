#import <Flutter/Flutter.h>

@interface DrLibphonenumberPlugin : NSObject<FlutterPlugin>
// NOTE: Append the lines below to ios/Classes/DrLibphonenumberPlugin.h

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

/**
 * We will call this stub function to prevent iOS from skipping the bundling of this library.
 */
void stub(void);

char *format(const char *phone_number,
             const char *iso_code,
             enum PhoneNumberFormat phone_number_format);

void free_c_char(char *str);
