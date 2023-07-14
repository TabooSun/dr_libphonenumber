use phonenumber::Metadata;

#[repr(C)]
#[derive(Debug, PartialEq)]
pub enum DrPhoneNumberType {
    ///
    FixedLine,

    ///
    Mobile,

    /// In some regions (e.g. the USA), it is impossible to distinguish between
    /// fixed-line and mobile numbers by looking at the phone number itself.
    FixedLineOrMobile,

    /// Freephone lines.
    TollFree,

    ///
    PremiumRate,

    /// The cost of this call is shared between the caller and the recipient, and
    /// is hence typically less than PREMIUM_RATE calls. See
    /// http://en.wikipedia.org/wiki/Shared_Cost_Service for more information.
    SharedCost,

    /// A personal number is associated with a particular person, and may be
    /// routed to either a MOBILE or FIXED_LINE number. Some more information can
    /// be found here: http://en.wikipedia.org/wiki/Personal_Numbers
    PersonalNumber,

    /// Voice over IP numbers. This includes TSoIP (Telephony Service over IP).
    Voip,

    ///
    Pager,

    /// Used for "Universal Access Numbers" or "Company Numbers". They may be
    /// further routed to specific offices, but allow one number to be used for a
    /// company.
    Uan,

    ///
    Emergency,

    /// Used for "Voice Mail Access Numbers".
    Voicemail,

    ///
    ShortCode,

    ///
    StandardRate,

    ///
    Carrier,

    ///
    NoInternational,

    /// A phone number is of type UNKNOWN when it does not fit any of the known
    /// patterns for a specific region.
    Unknown,
}


pub fn get_number_type(meta: &Metadata, value: &str) -> DrPhoneNumberType {
    if !meta.descriptors().general().is_match(value) {
        return DrPhoneNumberType::Unknown;
    }

    if meta.descriptors().premium_rate().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::PremiumRate;
    }

    if meta.descriptors().toll_free().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::TollFree;
    }

    if meta.descriptors().shared_cost().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::SharedCost;
    }

    if meta.descriptors().voip().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::Voip;
    }

    if meta.descriptors().personal_number().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::PersonalNumber;
    }

    if meta.descriptors().pager().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::Pager;
    }

    if meta.descriptors().uan().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::Uan;
    }

    if meta.descriptors().voicemail().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::Voicemail;
    }

    if meta.descriptors().fixed_line().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        if meta.descriptors().fixed_line().as_ref().map(|d| d.national_number().as_str()) ==
            meta.descriptors().mobile().as_ref().map(|d| d.national_number().as_str())
        {
            return DrPhoneNumberType::FixedLineOrMobile;
        }

        if meta.descriptors().mobile().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
            return DrPhoneNumberType::FixedLineOrMobile;
        }

        return DrPhoneNumberType::FixedLine;
    }

    if meta.descriptors().mobile().as_ref().map(|d| d.is_match(value)).unwrap_or(false) {
        return DrPhoneNumberType::Mobile;
    }

    DrPhoneNumberType::Unknown
}
