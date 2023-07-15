
import 'dr_libphonenumber_web_platform_interface.dart';

class DrLibphonenumberWeb {
  Future<String?> getPlatformVersion() {
    return DrLibphonenumberWebPlatform.instance.getPlatformVersion();
  }
}
