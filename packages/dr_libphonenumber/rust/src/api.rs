use std::str::FromStr;

use flutter_rust_bridge::SyncReturn;
use phonenumber::{Mode, PhoneNumber};
use phonenumber::country::Id;
use phonenumber::metadata::DATABASE;

use crate::dr_libphonenumber::models::phone_number_format::DrPhoneNumberFormat;
use crate::dr_libphonenumber::models::region_info::DrRegionInfo;
use crate::dr_libphonenumber::utils::number_type;
use crate::dr_libphonenumber::utils::number_type::DrPhoneNumberType;

/// Format the [phoneNumber] using the [phoneNumberFormat].
pub fn format(phone_number: String, iso_code: String, phone_number_format: DrPhoneNumberFormat) -> SyncReturn<String> {
    let country = parse_iso_code(iso_code).unwrap();

    let phone_number = parse_phone_number(phone_number, country).unwrap();

    let phone_number_format = phone_number_format.parse_to_mode();

    SyncReturn(phone_number.format().mode(phone_number_format).to_string())
}


pub fn get_number_type(phone_number: String, iso_code: String) -> SyncReturn<DrPhoneNumberType> {
    let country = parse_iso_code(iso_code).unwrap();

    let phone_number = parse_phone_number(phone_number, country).unwrap();

    let metadata = phone_number.metadata(&*DATABASE).unwrap_or_else(||
        panic!("Unable to retrieve metadata.")
    );

    let national_phone_number = phone_number.national().to_string();

    SyncReturn(number_type::get_number_type(metadata, &national_phone_number))
}


pub fn get_region_code_for_country_code(calling_code: u16) -> SyncReturn<String> {
    let region_code = (*DATABASE).by_code(&calling_code).unwrap_or_else(||
        panic!("Invalid calling_code: {}", calling_code)
    );

    let region_code = region_code.first().unwrap_or_else(||
        panic!("Unable to locate the region code for calling_code: {}", calling_code)
    );
    SyncReturn(region_code.id().to_string())
}


pub fn get_region_info(phone_number: String, iso_code: String) -> SyncReturn<DrRegionInfo> {
    let country = parse_iso_code(iso_code).unwrap();

    let phone_number = parse_phone_number(phone_number, country).unwrap();

    SyncReturn(DrRegionInfo {
        region_code: phone_number.country().code(),
        phone_number_value: phone_number.national().value(),
        country_code: country.as_ref().to_string(),
        formatted_phone_number: phone_number.format().mode(Mode::National).to_string(),
    })
}

/// Check if the [phoneNumber] is a valid phone number that satisfies all the
/// [DrPhoneNumberType] except [DrPhoneNumberType.Unknown].
pub fn is_valid_phone_number(phone_number: String, iso_code: String) -> SyncReturn<bool> {
    let country = parse_iso_code(iso_code).unwrap();

    let phone_number = parse_phone_number(phone_number, country).unwrap();

    SyncReturn(phone_number.is_valid())
}

fn parse_phone_number(phone_number: String, country: Id) -> Result<PhoneNumber, String> {
    return match phonenumber::parse(Some(country), &phone_number) {
        Ok(phone_number) => {
            Ok(phone_number)
        }
        Err(error) => {
            Err(format!("Unable to parse phone number: {}. The error was: {:?}", phone_number, error))
        }
    };
}

fn parse_iso_code(iso_code: String) -> Result<Id, String> {
    return match Id::from_str(iso_code.to_uppercase().as_str()) {
        Ok(country) => {
            Ok(country)
        }
        Err(_) => {
            Err(format!("Invalid ISO code: {}", iso_code))
        }
    };
}
