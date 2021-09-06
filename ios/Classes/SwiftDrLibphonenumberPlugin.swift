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
    format(nil, nil, PhoneNumberFormat.init(0))
    free_c_char(nil)
  }
}
