import Cocoa
import FlutterMacOS

public class DrLibphonenumberPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dr_libphonenumber", binaryMessenger: registrar.messenger)
    let instance = DrLibphonenumberPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  public static func dummyMethodToEnforceBundling() {
    format(nil, nil, DrPhoneNumberFormat.init(0))
    get_number_type(nil, nil)
    get_region_code_for_country_code(60)
    get_region_info(nil, nil)
    is_valid_phone_number(nil, nil)

    // Free memory.
    free_memory(nil)
  }
}
