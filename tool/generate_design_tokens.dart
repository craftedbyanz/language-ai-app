import 'dart:convert';
import 'dart:io';

const tokenSource = 'design-system/TOKENS.json';
const tokenOutput = 'lib/design_system/tokens/generated/design_tokens.dart';
const generatedHeader =
    '// GENERATED CODE - DO NOT EDIT.\n// Source: $tokenSource';

/// Build-time only. Reject unknown representations rather than dropping values.
class TokenGenerator {
  TokenGenerator(this.source);

  final Map<String, Object?> source;
  final Map<String, Object?> _leaves = {};

  Object? resolve(Object? value, [Set<String> chain = const {}]) {
    if (value is String) {
      final alias = RegExp(r'^\{([^}]+)\}$').firstMatch(value);
      if (alias != null) {
        final path = alias[1]!;
        if (chain.contains(path)) throw FormatException('Alias cycle: $path');
        Object? target = source;
        for (final key in path.split('.')) {
          if (target is! Map<String, Object?> || !target.containsKey(key)) {
            throw FormatException('Missing alias: $path');
          }
          target = target[key];
        }
        if (target is Map<String, Object?> && target.containsKey('value')) {
          target = target['value'];
        }
        return resolve(target, {...chain, path});
      }
      return value.replaceAllMapped(RegExp(r'\{([^}]+)\}'), (match) {
        final resolved = resolve('{${match[1]}}', chain);
        if (resolved is! String && resolved is! num) {
          throw FormatException('Non-scalar embedded alias: ${match[1]}');
        }
        return '$resolved';
      });
    }
    if (value is List<Object?>) {
      return value.map((item) => resolve(item, chain)).toList();
    }
    if (value is Map<String, Object?>) {
      return value.map((key, item) => MapEntry(key, resolve(item, chain)));
    }
    return value;
  }

  void _collect(String path, Object? node) {
    if (node is! Map<String, Object?>) {
      throw FormatException('Expected token object: $path');
    }
    if (node.containsKey('value')) {
      _leaves[path] = resolve(node['value']);
    } else if (node.containsKey('size')) {
      _leaves[path] = resolve(node);
    } else if (node.containsKey('blur') && node.containsKey('fill')) {
      _leaves['$path.blur'] = resolve(node['blur']);
      _leaves['$path.fill'] = resolve(node['fill']);
    } else {
      for (final key in node.keys.toList()..sort()) {
        if (!key.startsWith('_')) _collect('$path.$key', node[key]);
      }
    }
  }

  String generate() {
    _leaves.clear();
    for (final key in source.keys.toList()..sort()) {
      if (key != 'meta' && !key.startsWith('_')) _collect(key, source[key]);
    }
    final meta = source['meta']! as Map<String, Object?>;
    final profile = meta['colorProfile']! as Map<String, Object?>;
    if (profile['default'] != 'production') {
      throw const FormatException('Production must remain the default profile');
    }
    final overrides = profile['fidelityOverrides']! as Map<String, Object?>;
    for (final entry in overrides.entries) {
      if (!entry.key.startsWith('accessible.') ||
          !_leaves.containsKey(entry.key)) {
        throw FormatException('Invalid profile override: ${entry.key}');
      }
      resolve(entry.value);
    }
    final out = StringBuffer('''$generatedHeader

import 'package:flutter/material.dart';

enum ColorProfile { production, fidelity }

/// Canonical paired colors; never derive a foreground from a background.
class AnswerColors {
  const AnswerColors({required this.background, required this.foreground});
  final Color background;
  final Color foreground;
}

''');
    for (final group in source.keys.toList()..sort()) {
      if (group == 'meta' || group.startsWith('_')) continue;
      final className = '${_pascal(group)}Tokens';
      if (group == 'accessible') {
        out.writeln('class $className {');
        out.writeln(
          '  const $className({this.profile = ColorProfile.production});',
        );
        out.writeln('  final ColorProfile profile;');
      } else {
        out.writeln('abstract final class $className {');
      }
      final names = <String>{};
      for (final entry in _leaves.entries.where(
        (e) => e.key.startsWith('$group.'),
      )) {
        final path = entry.key;
        // Server-owned score thresholds are deliberately not client constants.
        if (path == 'score.thresholds') continue;
        if (group == 'answerPalette' &&
            (path.endsWith('.background') || path.endsWith('.foreground'))) {
          continue;
        }
        final name = _camel(path.substring(group.length + 1));
        if (!names.add(name)) {
          throw FormatException('Identifier collision: $path');
        }
        final (type, expression) = _render(path, entry.value);
        out.writeln('  /// $path');
        if (group == 'accessible') {
          final override = overrides[path];
          final fidelity = override == null
              ? expression
              : _render(path, resolve(override)).$2;
          out.writeln(
            '  $type get $name => profile == ColorProfile.fidelity ? $fidelity : $expression;',
          );
        } else {
          out.writeln('  static const $type $name = $expression;');
        }
        if (entry.value case final Map<String, Object?> typography) {
          if (typography['transform'] case final String transform) {
            out.writeln(
              '  static const String ${name}Transform = ${jsonEncode(transform)};',
            );
          }
        }
      }
      if (group == 'answerPalette') {
        final order = _leaves['answerPalette.order']! as List<Object?>;
        for (final key in order.cast<String>()) {
          final background = _render(
            'answerPalette.$key.background',
            _leaves['answerPalette.$key.background'],
          ).$2;
          final foreground = _render(
            'answerPalette.$key.foreground',
            _leaves['answerPalette.$key.foreground'],
          ).$2;
          out.writeln(
            '  static const AnswerColors $key = AnswerColors(background: $background, foreground: $foreground);',
          );
        }
        for (final name in ['writing', 'grammar']) {
          if (!order.contains(_leaves['answerPalette.defaults.$name'])) {
            throw FormatException('Invalid answer palette default: $name');
          }
        }
      }
      out.writeln('}\n');
    }
    return out.toString();
  }

  (String, String) _render(String path, Object? value) {
    if (value is num) {
      if (path == 'motion.fast' ||
          path == 'motion.sheet' ||
          path == 'motion.feedbackMinimumDwell') {
        return ('Duration', 'Duration(milliseconds: $value)');
      }
      return ('double', value.toDouble().toString());
    }
    if (value is List<Object?>) {
      final entries = value.map((v) => _render(path, v)).toList();
      final types = entries.map((v) => v.$1).toSet();
      if (types.length != 1) throw FormatException('Mixed/empty list: $path');
      final type = types.single;
      return ('List<$type>', '<$type>[${entries.map((v) => v.$2).join(', ')}]');
    }
    if (value is Map<String, Object?> && value.containsKey('size')) {
      final size = value['size']! as num;
      final height = value['lineHeight']! as num;
      final weight = value['weight']! as int;
      if (weight < 100 || weight > 900 || weight % 100 != 0 || size <= 0) {
        throw FormatException('Invalid typography: $path');
      }
      var letterSpacing = '';
      if (value['letterSpacing'] case final String em) {
        if (!em.endsWith('em')) throw FormatException('Unknown spacing: $path');
        letterSpacing =
            ', letterSpacing: ${double.parse(em.substring(0, em.length - 2)) * size}';
      }
      return (
        'TextStyle',
        'TextStyle(fontSize: $size, height: ${height / size}, fontWeight: FontWeight.w$weight$letterSpacing)',
      );
    }
    if (value is String) {
      if (RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(value)) {
        return ('Color', 'Color(0xFF${value.substring(1).toUpperCase()})');
      }
      final rgba = RegExp(r'^rgba\((\d+),(\d+),(\d+),([0-9.]+)\)$')
          .firstMatch(value);
      if (rgba != null) {
        return (
          'Color',
          'Color.fromRGBO(${rgba[1]}, ${rgba[2]}, ${rgba[3]}, ${rgba[4]})',
        );
      }
      if (path.startsWith('shadow.')) {
        if (value == 'none') return ('List<BoxShadow>', '<BoxShadow>[]');
        final shadow = RegExp(
          r'^(-?\d+)(?:px)? (-?\d+)(?:px)? (\d+)(?:px)?(?: (\d+)px)? (.+)$',
        ).firstMatch(value);
        if (shadow == null) throw FormatException('Unknown shadow: $path');
        return (
          'List<BoxShadow>',
          '<BoxShadow>[BoxShadow(offset: Offset(${shadow[1]}, ${shadow[2]}), blurRadius: ${shadow[3]}, spreadRadius: ${shadow[4] ?? 0}, color: ${_render(path, shadow[5]).$2})]',
        );
      }
      if (path == 'motion.easing') {
        if (value != 'ease-out') throw FormatException('Unknown curve: $value');
        return ('Curve', 'Curves.easeOut');
      }
      return ('String', jsonEncode(value).replaceAll(r'$', r'\$'));
    }
    throw FormatException('Unsupported token: $path = $value');
  }
}

String _pascal(String value) => value
    .split(RegExp(r'[._]'))
    .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
    .join();
String _camel(String value) {
  final pascal = _pascal(value);
  return '${pascal[0].toLowerCase()}${pascal.substring(1)}';
}

Future<String> formattedTokens({String sourcePath = tokenSource}) async {
  final source =
      jsonDecode(File(sourcePath).readAsStringSync()) as Map<String, Object?>;
  final temporary = Directory.systemTemp.createTempSync('lingua_tokens_');
  try {
    final file = File('${temporary.path}/tokens.dart')
      ..writeAsStringSync(TokenGenerator(source).generate());
    final result = await Process.run(_dartExecutable(), ['format', file.path]);
    if (result.exitCode != 0) {
      throw StateError('Token format failed: ${result.stderr}');
    }
    return file.readAsStringSync();
  } finally {
    temporary.deleteSync(recursive: true);
  }
}

Future<void> main() async {
  final output = await formattedTokens();
  File(tokenOutput)
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(output);
  stdout.writeln('Generated $tokenOutput');
}

String _dartExecutable() {
  if (Platform.resolvedExecutable.endsWith('/dart') ||
      Platform.resolvedExecutable.endsWith('/dart.exe')) {
    return Platform.resolvedExecutable;
  }
  // flutter test hosts tests in flutter_tester, not the Dart command-line VM.
  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  if (flutterRoot == null) {
    throw StateError('FLUTTER_ROOT is required when invoked by flutter_tester');
  }
  return '$flutterRoot/bin/cache/dart-sdk/bin/dart';
}
