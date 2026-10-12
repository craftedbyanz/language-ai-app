enum HistoryMode { writing, grammar }

final class HistoryEntry {
  const HistoryEntry({
    required this.id,
    required this.mode,
    required this.topicId,
    required this.type,
    required this.topic,
  });

  final String id;
  final HistoryMode mode;
  final String topicId;
  final String type;
  final String topic;
}

final class InsightSnapshot {
  const InsightSnapshot({
    required this.lessons,
    required this.writing,
    required this.grammar,
    required this.conversations,
    required this.words,
    required this.reviews,
    required this.currentStreak,
    required this.longestStreak,
    required this.weekActivity,
    required this.activeDaysThisMonth,
    required this.history,
  });

  final int lessons;
  final int writing;
  final int grammar;
  final int conversations;
  final int words;
  final int reviews;
  final int currentStreak;
  final int longestStreak;
  final List<int> weekActivity;
  final Set<int> activeDaysThisMonth;
  final List<HistoryEntry> history;
}

abstract interface class InsightRepository {
  InsightSnapshot load();
}
