library dr_libphonenumber;

import 'dart:async';

import 'package:dr_libphonenumber/src/ffi_dr_libphonenumber_stub.dart'
    if (dart.library.io) 'package:dr_libphonenumber/src/ffi_dr_libphonenumber.dart'
    if (dart.library.html) 'package:dr_libphonenumber/src/web_dr_libphonenumber.dart';
import 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

export 'package:dr_libphonenumber_platform_interface/dr_libphonenumber_platform_interface.dart'
    show
        RegionInfo,
        PhoneNumberType,
        PhoneNumberFormat,
        PhoneNumberTypeHelper,
        DrLibphonenumberPlatform,
        PhoneNumberTypeExt,
        PhoneNumberFormatExt,
        DrLibphonenumberException;

part 'src/dr_libphonenumber.dart';
