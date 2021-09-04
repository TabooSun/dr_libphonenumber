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
3. Add the path to `pubspec`

