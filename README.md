# Under development
This plugin is still under development.

# dr_libphonenumber

A Flutter plugin that uses FFI to access [libphonenumber](https://github.com/rustonaut/rust-phonenumber).

## Getting Started

Set Android NDK environment:

```shell
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export ANDROID_NDK_HOME=/Users/$USER/Library/Android/sdk/ndk-bundle
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME
```

Run the following commands to get started.

```shell
make init
```

The command above installs all the dependencies needed to the machine.

Next, run

```shell
make all
```

It generates all the NDKs.

Check [here](https://github.com/TabooSun/flutter-rust-ffi) for the rest.

## Flutter `ffigen`
1. Run `brew install llvm` to install `llvm`.
2. Run `brew list llvm` to locate the `llvm`.
3. Add the path to `ffigen_config.yaml`.

## The process above are for initial setup. The following are subsequent steps for updating the Rust code.

### Note: Each of the changing working directory steps below is referenced from the root directory. 

### Build
1. Change working directory to `native/dr_libphonenumber`.
2. Run `make clean`.
3. Run `make all`.
4. Run `make bindings`.
5. Run `make archive`.

Change the third step to android or ios if for some reason you want to build only specific platform.

## Generate Dart bindings
1. Run `flutter pub run ffigen --config ffigen_config.yaml`.
