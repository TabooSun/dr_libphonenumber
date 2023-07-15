#!/bin/bash

RUST_PROJECT_DIR=../packages/dr_libphonenumber/rust
LIBRARY_PATH=../packages/dr_libphonenumber_web

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

rustup toolchain install nightly
rustup +nightly component add rust-src
rustup +nightly target add wasm32-unknown-unknown
cargo install wasm-pack

wasm-pack build $RUST_PROJECT_DIR --out-dir web --target no-modules

rm -rf web
mv $RUST_PROJECT_DIR/web web

WASM_INSTALLATION_DIR=$LIBRARY_PATH/pkg/rust
mkdir -p $WASM_INSTALLATION_DIR
cp -r web/* $WASM_INSTALLATION_DIR