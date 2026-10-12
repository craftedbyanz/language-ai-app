import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../../../tool/generate_design_tokens.dart';

void main() {
  test(
    'canonical tokens parse, resolve and regenerate deterministically',
    () async {
      final source = jsonDecode(
        File(tokenSource).readAsStringSync(),
      ) as Map<String, Object?>;
      final generator = TokenGenerator(source);
      expect(generator.generate(), generator.generate());
      final formatted = await formattedTokens();
      expect(formatted, File(tokenOutput).readAsStringSync());
      expect(await formattedTokens(), formatted);
      expect(formatted, isNot(contains('lowMax')));
    },
  );
  test('missing and cyclic aliases fail with the offending path', () {
    expect(
      () => TokenGenerator({}).resolve('{missing}'),
      throwsFormatException,
    );
    expect(
      () => TokenGenerator({
        'a': {'value': '{b}'},
        'b': {'value': '{a}'},
      }).resolve('{a}'),
      throwsFormatException,
    );
  });
  test('production is default and fidelity only changes approved mappings', () {
    const production = AccessibleTokens();
    const fidelity = AccessibleTokens(profile: ColorProfile.fidelity);
    expect(production.brandFill, ColorTokens.primaryStrong);
    expect(fidelity.brandFill, ColorTokens.primary);
    expect(production.onBrand, fidelity.onBrand);
    expect(
      AnswerPaletteTokens.purple.background,
      FeatureTokens.writingAnswerCard,
    );
    expect(AnswerPaletteTokens.purple.foreground, ColorTokens.textPrimary);
    expect(AnswerPaletteTokens.defaultsWriting, 'purple');
  });
  test('every canonical answer pair meets body-text contrast', () {
    for (final pair in [
      AnswerPaletteTokens.purple,
      AnswerPaletteTokens.blue,
      AnswerPaletteTokens.indigo,
      AnswerPaletteTokens.green,
      AnswerPaletteTokens.lime,
      AnswerPaletteTokens.ink,
      AnswerPaletteTokens.white,
    ]) {
      final a = pair.background.computeLuminance();
      final b = pair.foreground.computeLuminance();
      final contrast = (math.max(a, b) + 0.05) / (math.min(a, b) + 0.05);
      expect(contrast, greaterThanOrEqualTo(4.5));
    }
  });
}
