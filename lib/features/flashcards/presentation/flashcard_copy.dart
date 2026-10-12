final class FlashcardCopy {
  const FlashcardCopy({
    required this.title,
    required this.back,
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
  });

  final String title;
  final String back;
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
}
