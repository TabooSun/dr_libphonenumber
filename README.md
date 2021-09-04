# dr_libphonenumber

A new Flutter project.

## Getting Started

Set Android NDK environment:

```shell
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export ANDROID_NDK_HOME=/Users/$USER/Library/Android/sdk/ndk-bundle
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME
```

Run the following commands to get started.

1. `rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android`
2. `rustup target add aarch64-apple-ios x86_64-apple-ios`
3. `cargo install cargo-lipo`
4. `cargo install cbindgen`
