mod dr_libphonenumber;

pub mod clean_up {
    pub mod free_memory;
}
pub use crate::clean_up::free_memory;

mod tests {
    pub mod test_dr_libphonenumber;
}
pub use crate::tests::test_dr_libphonenumber;

mod utils {
    pub mod string_helper;
}
pub use crate::utils::string_helper;
