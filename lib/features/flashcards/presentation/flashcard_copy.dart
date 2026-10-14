final class FlashcardCopy {
  const FlashcardCopy({
    required this.title,
    required this.back,
    required this.close,
    required this.deckCount,
    required this.newLabel,
    required this.learningLabel,
    required this.dueLabel,
    required this.deckSummary,
    required this.reviewLabel,
    required this.wordsLabel,
    required this.gameLabel,
    required this.emptyTitle,
    required this.emptyBody,
    required this.unavailableTitle,
    required this.unavailableBody,
    required this.flipHint,
    required this.again,
    required this.hard,
    required this.good,
    required this.easy,
    required this.completeTitle,
    required this.completeBody,
    required this.done,
    required this.practiceNotice,
  });

  final String title;
  final String back;
  final String close;
  final String Function(int count) deckCount;
  final String newLabel;
  final String learningLabel;
  final String dueLabel;
  final String Function(int newCount, int learningCount, int dueCount)
  deckSummary;
  final String Function(int count) reviewLabel;
  final String wordsLabel;
  final String gameLabel;
  final String emptyTitle;
  final String emptyBody;
  final String unavailableTitle;
  final String unavailableBody;
  final String flipHint;
  final String again;
  final String hard;
  final String good;
  final String easy;
  final String completeTitle;
  final String completeBody;
  final String done;
  final String practiceNotice;
}
