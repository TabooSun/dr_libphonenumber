class PlatformChannel {
  static const methodChannelName = "tech_creator.com/libphonenumber";
}

class PlatformChannelMethod {
  static const isValidPhoneNumber = 'isValidPhoneNumber';
  static const normalizePhoneNumber = 'normalizePhoneNumber';
  static const getRegionInfo = 'getRegionInfo';
  static const getNumberType = 'getNumberType';
  static const formatAsYouType = 'formatAsYouType';
  static const format = 'format';
  static const getRegionCodeForCountryCode = 'getRegionCodeForCountryCode';
}

class PlatformChannelArg {
  static const phone_number = 'phone_number';
  static const iso_code = 'iso_code';
  static const numberFormat = 'number_format';
  static const callingCode  = 'calling_code';
}
