use std::os::raw::c_void;

#[no_mangle]
pub extern "C" fn free_memory(unsafe_struct: *mut c_void) {
    if unsafe_struct.is_null() { return; }
    unsafe {
        let _ = Box::from_raw(unsafe_struct);
    }
}
