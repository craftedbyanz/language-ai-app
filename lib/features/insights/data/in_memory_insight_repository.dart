import '../domain/insight_snapshot.dart';

/// Empty local development state until a progress backend adapter is connected.
final class InMemoryInsightRepository implements InsightRepository {
  const InMemoryInsightRepository();

  @override
  InsightSnapshot load() => const InsightSnapshot(
    lessons: 0,
    writing: 0,
    grammar: 0,
    conversations: 0,
    words: 0,
    reviews: 0,
    currentStreak: 0,
    longestStreak: 0,
    weekActivity: [0, 0, 0, 0, 0, 0, 0],
    activeDaysThisMonth: {},
    history: [],
  );
}
