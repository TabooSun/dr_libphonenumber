get-dependencies:
    #!/usr/bin/env sh
    cd dr_libphonenumber
    flutter pub get
    dart pub global activate melos
    flutter pub global run melos bootstrap

generate-bindings:
    #!/usr/bin/env sh
    cd dr_libphonenumber
    flutter pub run ffigen --config ffigen_config.yaml