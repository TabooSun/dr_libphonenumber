#[cfg(test)]
mod tests {
    use std::ffi::CString;
    use std::os::raw::c_char;

    use crate::{clean_up, dr_libphonenumber, string_helper};
    use crate::dr_libphonenumber::PhoneNumberFormat;
    use crate::utils::number_type;

    static PHONE_NUMBER: &'static str = "0129602189";
    static ISO_CODE: &'static str = "MY";

    #[test]
    fn format_phone_number_in_e164_format() {
        let phone_number = dr_libphonenumber::format(parse_str_to_c_char(PHONE_NUMBER), parse_str_to_c_char(ISO_CODE), PhoneNumberFormat::E164);
        assert_eq!(string_helper::parse_c_char_to_str(phone_number, "phone_number"), String::from("+60129602189"));
        free_memory(phone_number);
    }

    #[test]
    fn format_phone_number_in_international_format() {
        let phone_number = dr_libphonenumber::format(parse_str_to_c_char(PHONE_NUMBER), parse_str_to_c_char(ISO_CODE), PhoneNumberFormat::International);
        assert_eq!(string_helper::parse_c_char_to_str(phone_number, "phone_number"), String::from("+60 12-960 2189"));
        free_memory(phone_number);
    }

    #[test]
    fn format_phone_number_in_national_format() {
        let phone_number = dr_libphonenumber::format(parse_str_to_c_char(PHONE_NUMBER), parse_str_to_c_char(ISO_CODE), PhoneNumberFormat::National);
        assert_eq!(string_helper::parse_c_char_to_str(phone_number, "phone_number"), String::from("012-960 2189"));
        free_memory(phone_number);
    }

    #[test]
    fn format_phone_number_in_rfc3966_format() {
        let phone_number = dr_libphonenumber::format(parse_str_to_c_char(PHONE_NUMBER), parse_str_to_c_char(ISO_CODE), PhoneNumberFormat::Rfc3966);
        assert_eq!(string_helper::parse_c_char_to_str(phone_number, "phone_number"), String::from("tel:+60-12-960-2189"));
        free_memory(phone_number);
    }

    #[test]
    fn format_phone_number_with_lowercase_iso_code() {
        let phone_number = dr_libphonenumber::format(parse_str_to_c_char(PHONE_NUMBER), parse_str_to_c_char("my"), PhoneNumberFormat::International);
        assert_eq!(string_helper::parse_c_char_to_str(phone_number, "phone_number"), String::from("+60 12-960 2189"));
        free_memory(phone_number);
    }

    #[test]
    fn get_number_type() {
        let phone_number_type = dr_libphonenumber::getNumberType(parse_str_to_c_char(PHONE_NUMBER), parse_str_to_c_char(ISO_CODE));
        assert_eq!(phone_number_type, number_type::PhoneNumberType::Mobile);
    }

    fn parse_str_to_c_char(s: &str) -> *const c_char {
        CString::new(s).unwrap().into_raw()
    }

    fn free_memory(phone_number: *mut c_char) {
        clean_up::free_memory::free_c_char(phone_number);
    }
}
