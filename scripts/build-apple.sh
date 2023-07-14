#!/bin/bash

LIBRARY_PATH=../packages/flutter_dr_libphonenumber

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

# Build static libs
for TARGET in \
        aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim \
        x86_64-apple-darwin aarch64-apple-darwin
do
    rustup target add $TARGET
    cargo build -r --target=$TARGET
done

# Create XCFramework zip
FRAMEWORK="DrLibphonenumber.xcframework"
LIBNAME=libdr_libphonenumber.a
DYLIBNAME=libdr_libphonenumber.dylib

INTEL_ARCH_RUST_TARGET_NAME=x86_64-apple-darwin
INTEL_ARCH_RUST_TARGET_DIR=../target/$INTEL_ARCH_RUST_TARGET_NAME/release
ARM_ARCH_RUST_TARGET_NAME=aarch64-apple-darwin
ARM_ARCH_RUST_TARGET_DIR=../target/$ARM_ARCH_RUST_TARGET_NAME/release

mkdir mac-lipo ios-sim-lipo
IOS_SIM_LIPO=ios-sim-lipo/$LIBNAME
MAC_LIPO=mac-lipo/$LIBNAME

MACOS_FRAMEWORK_DIR=Frameworks/macos
IOS_FRAMEWORK_DIR=Frameworks/ios

lipo -create -output $IOS_SIM_LIPO \
        ../target/aarch64-apple-ios-sim/release/$LIBNAME \
        ../target/x86_64-apple-ios/release/$LIBNAME
lipo -create -output $MAC_LIPO \
        ../target/aarch64-apple-darwin/release/$LIBNAME \
        ../target/x86_64-apple-darwin/release/$LIBNAME

# Create ios xcframework
xcodebuild -create-xcframework \
        -library $IOS_SIM_LIPO \
        -library ../target/aarch64-apple-ios/release/$LIBNAME \
        -output $IOS_FRAMEWORK_DIR/$FRAMEWORK

# Create macos xcframework
xcodebuild -create-xcframework \
        -library $MAC_LIPO \
        -output $MACOS_FRAMEWORK_DIR/$FRAMEWORK

cp -r $IOS_FRAMEWORK_DIR/$FRAMEWORK $LIBRARY_PATH/ios/Frameworks/
cp -r $MACOS_FRAMEWORK_DIR/$FRAMEWORK $LIBRARY_PATH/macos/Frameworks/

mkdir -p $INTEL_ARCH_RUST_TARGET_NAME/
cp $INTEL_ARCH_RUST_TARGET_DIR/$DYLIBNAME $INTEL_ARCH_RUST_TARGET_NAME/
mkdir -p $ARM_ARCH_RUST_TARGET_NAME/
cp $ARM_ARCH_RUST_TARGET_DIR/$DYLIBNAME $ARM_ARCH_RUST_TARGET_NAME/

#zip -r $FRAMEWORK.zip $FRAMEWORK

# Cleanup
rm -rf ios-sim-lipo mac-lipo $FRAMEWORK
