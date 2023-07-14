#[cfg(test)]
pub mod tests {
    use crate::api;
    use crate::dr_libphonenumber::models::phone_number_format::DrPhoneNumberFormat;
    use crate::dr_libphonenumber::utils::number_type::DrPhoneNumberType;

    static PHONE_NUMBER: &'static str = "0129602189";
    static ISO_CODE: &'static str = "MY";

    #[test]
    fn format_phone_number_in_e164_format() {
        let result = api::format(PHONE_NUMBER.to_string(), ISO_CODE.to_string(), DrPhoneNumberFormat::E164).0;
        assert_eq!(result, String::from("+60129602189"));
    }

    #[test]
    fn format_phone_number_in_international_format() {
        let result = api::format(PHONE_NUMBER.to_string(), ISO_CODE.to_string(), DrPhoneNumberFormat::International).0;
        assert_eq!(result, String::from("+60 12-960 2189"));
    }

    #[test]
    fn format_phone_number_in_national_format() {
        let result = api::format(PHONE_NUMBER.to_string(), ISO_CODE.to_string(), DrPhoneNumberFormat::National).0;
        assert_eq!(result, String::from("012-960 2189"));
    }

    #[test]
    fn format_phone_number_in_rfc3966_format() {
        let result = api::format(PHONE_NUMBER.to_string(), ISO_CODE.to_string(), DrPhoneNumberFormat::Rfc3966).0;
        assert_eq!(result, String::from("tel:+60-12-960-2189"));
    }

    #[test]
    fn format_phone_number_with_lowercase_iso_code() {
        let result = api::format(PHONE_NUMBER.to_string(), "my".to_string(), DrPhoneNumberFormat::International).0;
        assert_eq!(result, String::from("+60 12-960 2189"));
    }

    #[test]
    #[should_panic]
    fn format_invalid_phone_number_in_e164_format() {
        let _ = api::format(String::from("0"), ISO_CODE.to_string(), DrPhoneNumberFormat::E164).0;
    }

    #[test]
    fn get_number_type() {
        let phone_number_type = api::get_number_type(PHONE_NUMBER.to_string(), ISO_CODE.to_string()).0;
        assert_eq!(phone_number_type, DrPhoneNumberType::Mobile);
    }

    #[test]
    fn get_region_code_for_country_code() {
        let region_code = api::get_region_code_for_country_code(60).0;
        assert_eq!(region_code, ISO_CODE);
    }

    #[test]
    fn get_region_info() {
        let region_info = api::get_region_info(PHONE_NUMBER.to_string(), ISO_CODE.to_string()).0;
        assert_eq!(region_info.region_code, 60);
        assert_eq!(region_info.country_code, ISO_CODE);
        assert_eq!(region_info.phone_number_value, 129602189);
        assert_eq!(region_info.formatted_phone_number, "012-960 2189");
    }

    #[test]
    fn is_valid_phone_number() {
        let is_valid_phone_number = api::is_valid_phone_number(PHONE_NUMBER.to_string(), ISO_CODE.to_string()).0;
        assert_eq!(is_valid_phone_number, true);
    }
}
