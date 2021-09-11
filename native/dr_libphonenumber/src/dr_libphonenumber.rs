use std::ffi::CString;
use std::os::raw::c_char;
use std::str::FromStr;

use phonenumber::{
    country::Id,
    Metadata,
    metadata::DATABASE,
    Mode,
    PhoneNumber,
};

use crate::string_helper;
use crate::utils::number_type::{get_number_type, PhoneNumberType};

#[no_mangle]
pub extern "C" fn format(phone_number: *const c_char, iso_code: *const c_char, phone_number_format: PhoneNumberFormat) -> *mut c_char {
    let country = parse_iso_code(iso_code);

    let phone_number = parse_phone_number(phone_number, country);

    let phone_number_format = match phone_number_format {
        PhoneNumberFormat::E164 => { Mode::E164 }
        PhoneNumberFormat::International => { Mode::International }
        PhoneNumberFormat::National => { Mode::National }
        PhoneNumberFormat::Rfc3966 => { Mode::Rfc3966 }
    };
    CString::new(phone_number.format().mode(phone_number_format).to_string()).unwrap().into_raw()
}

#[no_mangle]
pub extern "C" fn getNumberType(phone_number: *const c_char, iso_code: *const c_char) -> PhoneNumberType {
    let country = parse_iso_code(iso_code);
    let metadata: &Metadata;

    let phone_number = parse_phone_number(phone_number, country);

    metadata = phone_number.metadata(&*DATABASE).unwrap_or_else(|| {
        panic!("Unable to retrieve metadata.");
    });

    let national_phone_number = phone_number.national().to_string();
    get_number_type(metadata, &national_phone_number)
}

fn parse_phone_number(phone_number: *const c_char, country: Id) -> PhoneNumber {
    let phone_number = string_helper::parse_c_char_to_str(phone_number, "phone_number");
    let phone_number = phonenumber::parse(Some(country), phone_number.clone())
        .unwrap_or_else(|error| {
            panic!("Error occurred when attempting to parse phone_number, {}, with the following error: {:?}", phone_number, error);
        });
    phone_number
}

fn parse_iso_code(iso_code: *const c_char) -> Id {
    let iso_code = string_helper::parse_c_char_to_str(iso_code, "iso_code");
    let country = phonenumber::country::Id::from_str(iso_code.to_uppercase().as_str()).unwrap_or_else(|error| {
        panic!("Error occurred when attempting to parse iso code, {}, with the following error: {:?}", iso_code, error);
    });
    country
}

#[repr(C)]
#[derive(Debug, PartialEq)]
pub enum PhoneNumberFormat {
    /// E.164 formatting, no spaces, no decorations.
    #[allow(dead_code)]
    E164,

    /// International formatting, contains country code and country dependent
    /// formatting.
    #[allow(dead_code)]
    International,

    /// National formatting, no country code and country dependent formatting.
    #[allow(dead_code)]
    National,

    /// RFC3966 formatting, see the RFC.
    #[allow(dead_code)]
    Rfc3966,
}
