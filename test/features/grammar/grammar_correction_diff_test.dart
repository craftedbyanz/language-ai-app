import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';
import 'package:lingua/features/grammar/presentation/state/grammar_correction_diff.dart';

void main() {
  test('maps a replacement into removed and inserted word segments', () {
    final result = buildGrammarCorrectionDiff(
      original: 'She work every day.',
      corrected: 'She works every day.',
    );

    expect(result.map((segment) => (segment.text, segment.kind)), [
      ('She', CorrectionSegmentKind.retained),
      ('work', CorrectionSegmentKind.removed),
      ('works', CorrectionSegmentKind.inserted),
      ('every', CorrectionSegmentKind.retained),
      ('day', CorrectionSegmentKind.retained),
      ('.', CorrectionSegmentKind.retained),
    ]);
  });

  test('handles repeated words and punctuation deterministically', () {
    final first = buildGrammarCorrectionDiff(
      original: 'We we walk home!',
      corrected: 'We walk home.',
    );
    final second = buildGrammarCorrectionDiff(
      original: 'We we walk home!',
      corrected: 'We walk home.',
    );

    expect(first.map((segment) => segment.kind), [
      CorrectionSegmentKind.retained,
      CorrectionSegmentKind.removed,
      CorrectionSegmentKind.retained,
      CorrectionSegmentKind.retained,
      CorrectionSegmentKind.removed,
      CorrectionSegmentKind.inserted,
    ]);
    expect(
      second.map((segment) => (segment.text, segment.kind)),
      first.map((segment) => (segment.text, segment.kind)),
    );
  });

  test('represents sentence-boundary insertions', () {
    final result = buildGrammarCorrectionDiff(
      original: 'Walk home.',
      corrected: 'Please walk home now.',
    );

    expect(result.first.kind, CorrectionSegmentKind.inserted);
    expect(result.first.text, 'Please');
    expect(
      result.singleWhere((segment) => segment.text == 'now').kind,
      CorrectionSegmentKind.inserted,
    );
  });
}
