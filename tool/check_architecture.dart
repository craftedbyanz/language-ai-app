import 'dart:io';

/// Masks comments while retaining strings, offsets and line breaks.
String withoutComments(String source) {
  final out = StringBuffer();
  var i = 0;
  while (i < source.length) {
    if (source.startsWith('//', i)) {
      while (i < source.length && source[i] != '\n') {
        out.write(' ');
        i++;
      }
    } else if (source.startsWith('/*', i)) {
      var depth = 1;
      out.write('  ');
      i += 2;
      while (i < source.length && depth > 0) {
        if (source.startsWith('/*', i)) {
          depth++;
          out.write('  ');
          i += 2;
        } else if (source.startsWith('*/', i)) {
          depth--;
          out.write('  ');
          i += 2;
        } else {
          out.write(source[i] == '\n' ? '\n' : ' ');
          i++;
        }
      }
    } else if (source[i] == "'" || source[i] == '"') {
      final quote = source[i];
      final delimiter = source.startsWith(quote * 3, i) ? quote * 3 : quote;
      out.write(delimiter);
      i += delimiter.length;
      while (i < source.length) {
        if (source.startsWith(delimiter, i)) {
          out.write(delimiter);
          i += delimiter.length;
          break;
        }
        if (source[i] == r'\' && i + 1 < source.length) {
          out.write(source.substring(i, i + 2));
          i += 2;
        } else {
          out.write(source[i]);
          i++;
        }
      }
    } else {
      out.write(source[i]);
      i++;
    }
  }
  return out.toString();
}

String? localPath(String from, String uri) {
  const packageRoots = <String, String>{
    'hifive': 'lib/',
    'lingua_auth': 'packages/lingua_auth/lib/',
    'lingua_design_system': 'packages/lingua_design_system/lib/',
    'lingua_networking': 'packages/lingua_networking/lib/',
  };
  if (uri.startsWith('package:')) {
    final packagePath = uri.substring('package:'.length);
    final separator = packagePath.indexOf('/');
    if (separator < 0) return null;
    final package = packagePath.substring(0, separator);
    final root = packageRoots[package];
    if (root == null) return null;
    return Uri(path: root)
        .resolve(packagePath.substring(separator + 1))
        .normalizePath()
        .path;
  }
  if (Uri.parse(uri).hasScheme) return null;
  return Uri(path: from).resolve(uri).normalizePath().path;
}

List<String> checkSource(String path, String source) {
  final errors = <String>[];
  final clean = withoutComments(source);
  final owner = RegExp(r'^lib/features/([^/]+)/').firstMatch(path)?[1];
  final domain = path.contains('/domain/');
  // Includes exports, parts and every branch of a conditional import/export.
  final directives = RegExp(
    r'''^\s*(?:import|export|part)\s+(?!of\b)([\s\S]*?);''',
    multiLine: true,
  );
  for (final directive in directives.allMatches(clean)) {
    for (final literal in RegExp(
      r'''['"]([^'"]+)['"]''',
    ).allMatches(directive[1]!)) {
      final uri = literal[1]!;
      final target = localPath(path, uri);
      void reject(String reason) => errors.add('$path: $reason ($uri)');
      if (domain) {
        const pureDart = {
          'dart:async',
          'dart:collection',
          'dart:core',
          'dart:math',
          'dart:typed_data',
        };
        final ownDomain =
            owner != null &&
            target != null &&
            target.startsWith('lib/features/$owner/domain/');
        final pureCore =
            target != null &&
            (target.startsWith('lib/core/result/') ||
                target.startsWith('lib/core/error/'));
        if (!pureDart.contains(uri) && !ownDomain && !pureCore) {
          reject('domain must remain pure Dart');
        }
      }
      if (path.startsWith('lib/core/') &&
          target != null &&
          (target.startsWith('lib/features/') ||
              target.startsWith('lib/app/') ||
              target.startsWith('packages/lingua_design_system/lib/'))) {
        reject('core cannot depend on app, features or design_system');
      }
      if (path.startsWith('packages/lingua_design_system/lib/') &&
          target != null &&
          (target.startsWith('lib/features/') ||
              target.startsWith('lib/app/') ||
              target.startsWith('lib/generated/') ||
              target.startsWith('packages/lingua_auth/') ||
              target.startsWith('packages/lingua_networking/'))) {
        reject('design_system cannot depend on app, features, auth or network');
      }
      if (path.startsWith('packages/lingua_networking/lib/') &&
          target != null &&
          (target.startsWith('lib/') ||
              target.startsWith('packages/lingua_auth/') ||
              target.startsWith('packages/lingua_design_system/'))) {
        reject('networking cannot depend on app, auth or design_system');
      }
      if (path.startsWith('packages/lingua_auth/lib/') &&
          !const {
            'dart:async',
            'dart:collection',
            'dart:core',
            'dart:math',
            'dart:typed_data',
          }.contains(uri) &&
          !(target?.startsWith('packages/lingua_auth/lib/') ?? false)) {
        reject('auth must remain pure Dart and transport independent');
      }
      if (owner != null && target != null) {
        if (target.startsWith('lib/app/')) {
          reject('features cannot depend on app');
        }
        if (path.contains('/presentation/') &&
            target.startsWith('lib/generated/api/')) {
          reject('presentation cannot import generated API');
        }
        final other = RegExp(r'^lib/features/([^/]+)/(.+)$').firstMatch(target);
        if (other != null &&
            other[1] != owner &&
            other[2] != '${other[1]}.dart') {
          reject('cross-feature imports must use the public feature barrel');
        }
      }
      if ((path.startsWith('lib/core/error/') ||
              path.startsWith('lib/core/result/')) &&
          !uri.startsWith('dart:') &&
          !(target != null &&
              (target.startsWith('lib/core/error/') ||
                  target.startsWith('lib/core/result/')))) {
        reject('Result/AppFailure must remain framework independent');
      }
    }
  }
  if (RegExp(r'\bclass\s+Base(?:ViewModel|Repository|Service|UseCase|Screen)\b')
      .hasMatch(clean)) {
    errors.add('$path: premature generic base abstraction');
  }
  if (path.startsWith(
        'packages/lingua_design_system/lib/src/tokens/generated/',
      ) &&
      (!source.contains('GENERATED CODE - DO NOT EDIT') ||
          !source.contains('Source: design-system/TOKENS.json'))) {
    errors.add('$path: missing token provenance header');
  }
  if (path.startsWith('lib/generated/api/') &&
      !RegExp(r'GENERATED|generated|DO NOT EDIT').hasMatch(source)) {
    errors.add('$path: generated API requires generator provenance');
  }
  return errors;
}

List<String> checkArchitecture({String root = '.'}) {
  final errors = <String>[];
  for (final name in ['utils', 'helpers', 'common', 'misc', 'managers']) {
    if (Directory('$root/lib/$name').existsSync() ||
        Directory('$root/$name').existsSync()) {
      errors.add('$name: forbidden architectural dumping ground');
    }
  }
  final libraryRoots = <String>['lib'];
  final packages = Directory('$root/packages');
  if (packages.existsSync()) {
    for (final package in packages.listSync().whereType<Directory>()) {
      final packageName = package.path.split(Platform.pathSeparator).last;
      libraryRoots.add('packages/$packageName/lib');
    }
  }
  for (final libraryRoot in libraryRoots) {
    final lib = Directory('$root/$libraryRoot');
    if (!lib.existsSync()) continue;
    final files =
        lib
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .where((file) => file.path.endsWith('.dart'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));
    for (final file in files) {
      final path = '$libraryRoot/${file.path.substring(lib.path.length + 1)}';
      errors.addAll(checkSource(path, file.readAsStringSync()));
    }
  }
  return errors;
}

void main() {
  final errors = checkArchitecture();
  if (errors.isNotEmpty) {
    stderr.writeln(errors.join('\n'));
    exitCode = 1;
  } else {
    stdout.writeln('Architecture boundaries verified.');
  }
}
