final class InsightCopy {
  const InsightCopy({
    required this.title,
    required this.history,
    required this.streak,
    required this.back,
    required this.lessons,
    required this.writing,
    required this.grammar,
    required this.conversations,
    required this.words,
    required this.reviews,
    required this.currentStreak,
    required this.longestStreak,
    required this.monthYear,
    required this.weekTitle,
    required this.weekEmpty,
    required this.weekdayLabels,
    required this.historySearch,
    required this.historySearchHint,
    required this.historyEmptyTitle,
    required this.historyEmptyBody,
    required this.historyNoResults,
  });

  final String title;
  final String history;
  final String streak;
  final String back;
  final String lessons;
  final String writing;
  final String grammar;
  final String conversations;
  final String words;
  final String reviews;
  final String currentStreak;
  final String longestStreak;
  final String Function(int month, int year) monthYear;
  final String weekTitle;
  final String weekEmpty;
  final List<String> weekdayLabels;
  final String historySearch;
  final String historySearchHint;
  final String historyEmptyTitle;
  final String historyEmptyBody;
  final String historyNoResults;
}
