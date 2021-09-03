use std::ffi::CStr;
use std::os::raw::c_char;

pub fn parse_c_char_to_str(char: *const c_char, name: &str) -> String {
    let c_str = unsafe {
        CStr::from_ptr(char)
    };
    let result = c_str.to_str().unwrap_or_else(|error| {
        panic!("Error occurred when attempting to parse {}, with the following error: {:?}", name, error);
    });
    String::from(result)
}
