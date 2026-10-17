final class InsightCopy {
  const InsightCopy({
    required this.title,
    required this.history,
    required this.streak,
    required this.streakOnFire,
    required this.streakCurrentLabel,
    required this.streakLongestLabel,
    required this.streakConsecutiveDays,
    required this.streakStartPrompt,
    required this.streakStudiedDays,
    required this.streakPreviousMonth,
    required this.streakNextMonth,
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
    required this.historySectionWriting,
    required this.historyReviewTitle,
    required this.historySectionGrammar,
    required this.historySectionConversation,
    required this.historySeeMore,
  });

  final String title;
  final String history;
  final String streak;
  final String streakOnFire;
  final String streakCurrentLabel;
  final String streakLongestLabel;
  final String streakConsecutiveDays;
  final String streakStartPrompt;
  final String Function(int count) streakStudiedDays;
  final String streakPreviousMonth;
  final String streakNextMonth;
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
  final String historySectionWriting;
  final String historyReviewTitle;
  final String historySectionGrammar;
  final String historySectionConversation;
  final String historySeeMore;
}
