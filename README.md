# dr_libphonenumber

A Flutter plugin that uses FFI to access [libphonenumber](https://github.com/rustonaut/rust-phonenumber).

## Getting started

### Android
This plugin works out of the box.

### iOS
- The static library will be stripped in release mode. Follow [this](https://flutter.dev/docs/development/platform-integration/c-interop#ios-symbols-stripped)
to prevent.
- This library does not support `armv7` and `armv7s`. Therefore, you need to configure the build target to support only arm64.
  1. Open iOS project in XCode.
  2. Go to `Target Runner > Build Settings > Architectures`
  3. Set the `Architectures` from `Standard Architectures (arm64, armv7)` to `arm64`.

## Feature request
This plugin does not support all the features from the Google libphonenumber. You can file an issue and I will work on 
it. Alternatively, you can also create a PR to contribute.

## Contribution

Download NDK (version 22.0.7026061) from Android Studio SDK manager.

Set Android NDK environment:

```shell
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export ANDROID_NDK_HOME=/Users/$USER/Library/Android/sdk/ndk/24.0.8215888
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME
```

Change the working directory to `dr_libphonenumber/native/dr_libphonenumber`:

Run the following commands to get started.

```shell
make init
```

The command above installs all the dependencies required by the machine to build the static libraries.

Next, run

```shell
make all
```

It generates all the static libraries.

Check [here](https://github.com/TabooSun/flutter-rust-ffi) for the rest.

## Flutter `ffigen`
1. Run `brew install llvm` to install `llvm`.
2. Run `brew list llvm` to locate the `llvm`.
3. Add the path to `ffigen_config.yaml`.

> The processes above are for initial setup. The following are subsequent steps for updating the Rust code.

### Note: Each of the changing working directory steps below is referenced from the root directory. 

### Build
1. Change working directory to `native/dr_libphonenumber`.
2. Run `make all`.

## Generate Dart bindings
1. Run
    ```shell
    flutter pub run ffigen --config ffigen_config.yaml
    ```
