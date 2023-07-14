get-dependencies:
    #!/usr/bin/env sh
    dart pub global activate melos
    flutter pub global run melos bootstrap

cargo-clean:
    #!/usr/bin/env sh
    cd packages/dr_libphonenumber/rust
    cargo clean

cargo-build:
    #!/usr/bin/env sh
    cd packages/dr_libphonenumber/rust
    cargo build

build-android: cargo-build
    sh ./scripts/build-android.sh

build-apple: cargo-build
    sh ./scripts/build-apple.sh

build-win-linux: cargo-build
    sh ./scripts/build-win-linux.sh

build-all: build-android build-apple build-win-linux

#generate-bindings:
#    #!/usr/bin/env sh
#    cd dr_libphonenumber
#    flutter pub run ffigen --config ffigen_config.yaml