#import "DrLibphonenumberPlugin.h"
#if __has_include(<dr_libphonenumber/dr_libphonenumber-Swift.h>)
#import <dr_libphonenumber/dr_libphonenumber-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dr_libphonenumber-Swift.h"
#endif

@implementation DrLibphonenumberPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDrLibphonenumberPlugin registerWithRegistrar:registrar];
}
@end
