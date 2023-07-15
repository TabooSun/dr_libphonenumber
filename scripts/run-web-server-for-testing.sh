#!/usr/bin/env zsh

set -xe

cd packages/flutter_dr_libphonenumber/example
rm -rf build/web
flutter build web
cd build/web
npx @azure/static-web-apps-cli start --port 8080

#dart pub global activate flutter_rust_bridge
#flutter_rust_bridge_serve --crate ../../dr_libphonenumber/rust