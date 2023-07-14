# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(flutter_dr_libphonenumber_library VERSION 0.0.1 LANGUAGES C)

add_library(flutter_dr_libphonenumber SHARED
  "flutter_dr_libphonenumber.c"
)

set_target_properties(flutter_dr_libphonenumber PROPERTIES
  PUBLIC_HEADER flutter_dr_libphonenumber.h
  OUTPUT_NAME "flutter_dr_libphonenumber"
)

target_compile_definitions(flutter_dr_libphonenumber PUBLIC DART_SHARED_LIB)
