import Flutter
import UIKit

public class SwiftDrLibphonenumberPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // We are not using any Flutter Platform Channel.
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(nil)
  }

  public static func dummyMethodToEnforceBundling() {
    format(nil, nil, DrPhoneNumberFormat.init(0))
    format_as_you_type(nil, nil, DrPhoneNumberFormat.init(0))
    get_number_type(nil, nil)
    get_region_code_for_country_code(60)
    get_region_info(nil, nil)
    is_valid_phone_number(nil, nil)

    // Free memory.
    free_memory(nil)
  }
}
