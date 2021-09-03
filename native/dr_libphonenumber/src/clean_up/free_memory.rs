use std::ffi::CString;
use std::os::raw::c_char;

#[no_mangle]
pub extern "C" fn free_c_char(str: *mut c_char) {
    unsafe {
        if str.is_null() { return }
        CString::from_raw(str)
    };
}
