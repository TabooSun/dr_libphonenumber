use flutter_rust_bridge::frb;

/// Check https://countrycode.org/ for detail.
#[derive(Debug, PartialEq)]
#[frb(dart_metadata=("immutable" import "package:meta/meta.dart" as meta))]
pub struct DrRegionInfo {
    /// The region code or calling code.
    pub region_code: u16,

    /// The phone number excluding the [regionCode].
    pub phone_number_value: u64,

    /// The country code.
    pub country_code: String,

    /// The formatted phone number with combination of [regionCode] & [phoneNumberValue].
    pub formatted_phone_number: String,
}
