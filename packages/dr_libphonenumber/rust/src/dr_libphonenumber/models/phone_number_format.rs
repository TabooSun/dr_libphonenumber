use phonenumber::Mode;

#[repr(C)]
#[derive(Debug, PartialEq)]
pub enum DrPhoneNumberFormat {
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

impl DrPhoneNumberFormat {
    pub fn parse_to_mode(&self) -> Mode {
         match self {
             DrPhoneNumberFormat::E164 => { Mode::E164 }
             DrPhoneNumberFormat::International => { Mode::International }
             DrPhoneNumberFormat::National => { Mode::National }
             DrPhoneNumberFormat::Rfc3966 => { Mode::Rfc3966 }
         }
    }
}
