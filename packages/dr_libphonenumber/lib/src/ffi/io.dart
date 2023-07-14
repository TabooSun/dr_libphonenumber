import 'dart:ffi';
import 'dart:io';

import 'package:dr_libphonenumber/src/bridge_generated.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';

typedef ExternalLibrary = DynamicLibrary;

DrLibphonenumber createWrapperImpl(ExternalLibrary dylib) =>
    DrLibphonenumberImpl(dylib);

const String _base = 'dr_libphonenumber';

DynamicLibrary createLibraryImpl() {
  /*if (Platform.isIOS || Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('$base.dll');
  } else {
    return DynamicLibrary.open('lib$base.so');
  }*/

  if (Platform.isAndroid) {
    return DynamicLibrary.open('lib$_base.so')
      // Load the library. Our library is not that large, loading it here
      // should not be having any performance problem.
      ..providesSymbol('');
  }

  const flutterTestKey = 'FLUTTER_TEST';
  if (Platform.environment.containsKey(flutterTestKey) &&
      Platform.environment[flutterTestKey] == 'true' &&
      (Platform.isMacOS || Platform.isWindows)) {
    final String libPath = _detectLibraryByDevice();
    if (!File(libPath).existsSync()) {
      throw Exception(
        '$libPath not found. Please make sure that you have built all the Rust targets.',
      );
    }

    return DynamicLibrary.open(libPath);
  }

  return DynamicLibrary.process();
}

String _detectLibraryByDevice() {
  final Directory? workspaceProjectDirectory = _findFlutterProjectRoot(
    relativeTo: Directory.current,
  );
  if (workspaceProjectDirectory == null) {
    throw Exception(
      'dr_libphonenumber is not found in the current project.',
    );
  }
  final drLibphonenumberPackagePath = workspaceProjectDirectory.path;
  final artifactsDirParents = [
    drLibphonenumberPackagePath,
    'platform-build',
  ];
  if (Platform.isWindows) {
    final windowsArchitecture = Process.runSync(
      'wmic',
      [
        'cpu',
        'get',
        'architecture',
      ],
    ).stdout;

    if (windowsArchitecture is! String) {
      throw Exception(
        'Failed to detect the architecture of the current Windows machine.',
      );
    }

    return path.joinAll([
      ...artifactsDirParents,
      'windows-${windowsArchitecture.trim().toLowerCase()}/lib$_base.dll',
    ]);
  }

  final appleDarwinArchitecture = Process.runSync('arch', []).stdout;
  if (appleDarwinArchitecture is String &&
      appleDarwinArchitecture.trim() == 'arm64') {
    return path.joinAll([
      ...artifactsDirParents,
      'aarch64-apple-darwin/lib$_base.dylib',
    ]);
  }

  return path.joinAll(
    [
      ...artifactsDirParents,
      'x86_64-apple-darwin/lib$_base.dylib',
    ],
  );
}

Directory? _findFlutterProjectRoot({
  required Directory relativeTo,
}) {
  const flutterProjectRootSentinel = 'pubspec.yaml';
  var flutterProjectRoot = relativeTo;
  while (true) {
    final pubspecFile = File(
      path.join(
        flutterProjectRoot.path,
        flutterProjectRootSentinel,
      ),
    );
    if (pubspecFile.existsSync() &&
        Pubspec.parse(pubspecFile.readAsStringSync()).name ==
            'dr_libphonenumber_workspace') {
      break;
    }

    final parent = flutterProjectRoot.parent;
    if (parent.path == flutterProjectRoot.path) {
      return null;
    }
    flutterProjectRoot = parent;
  }

  return flutterProjectRoot;
}
