import '../../../../design_system/components/feedback_sheet.dart';

final RegExp _correctionTokenPattern = RegExp(
  r"[\p{L}\p{N}]+(?:['’][\p{L}\p{N}]+)?|[^\s\p{L}\p{N}]",
  unicode: true,
);

List<CorrectionSegment> buildGrammarCorrectionDiff({
  required String original,
  required String corrected,
}) {
  final before = _tokens(original);
  final after = _tokens(corrected);
  final lengths = List.generate(
    before.length + 1,
    (_) => List<int>.filled(after.length + 1, 0),
  );

  for (var left = before.length - 1; left >= 0; left--) {
    for (var right = after.length - 1; right >= 0; right--) {
      lengths[left][right] = _same(before[left], after[right])
          ? lengths[left + 1][right + 1] + 1
          : lengths[left + 1][right] >= lengths[left][right + 1]
          ? lengths[left + 1][right]
          : lengths[left][right + 1];
    }
  }

  final segments = <CorrectionSegment>[];
  var left = 0;
  var right = 0;
  while (left < before.length || right < after.length) {
    if (left < before.length &&
        right < after.length &&
        _same(before[left], after[right])) {
      segments.add(
        CorrectionSegment(
          text: after[right],
          kind: CorrectionSegmentKind.retained,
        ),
      );
      left++;
      right++;
    } else if (right < after.length &&
        (left == before.length ||
            lengths[left][right + 1] > lengths[left + 1][right])) {
      segments.add(
        CorrectionSegment(
          text: after[right++],
          kind: CorrectionSegmentKind.inserted,
        ),
      );
    } else {
      segments.add(
        CorrectionSegment(
          text: before[left++],
          kind: CorrectionSegmentKind.removed,
        ),
      );
    }
  }
  return List.unmodifiable(segments);
}

List<String> _tokens(String value) => _correctionTokenPattern
    .allMatches(value.trim())
    .map((match) => match.group(0)!)
    .toList(growable: false);

bool _same(String left, String right) =>
    left.toLowerCase() == right.toLowerCase();
