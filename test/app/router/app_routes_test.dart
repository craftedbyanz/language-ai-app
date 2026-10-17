import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/app/router/app_routes.dart';

void main() {
  test('Grammar typed route locations are stable', () {
    expect(const GrammarTopicRoute().location, '/grammar');
    expect(
      const GrammarLessonRoute(topicId: 'verb-agreement').location,
      '/grammar/verb-agreement',
    );
    expect(
      const GrammarExerciseRoute(
        topicId: 'verb-agreement',
        lessonId: 'third-person-present',
      ).location,
      '/grammar/verb-agreement/third-person-present',
    );
  });

  test('Writing typed route locations remain unchanged', () {
    expect(const WritingTopicRoute().location, '/writing');
    expect(
      const WritingLessonRoute(topicId: 'daily-routine').location,
      '/writing/daily-routine',
    );
    expect(
      const WritingExerciseRoute(
        topicId: 'daily-routine',
        lessonId: 'morning-routine',
      ).location,
      '/writing/daily-routine/morning-routine',
    );
  });

  test('Flashcard deck routes keep IDs in typed paths', () {
    expect(const FlashcardDecksRoute().location, '/flashcards');
    expect(
      const FlashcardDeckRoute(deckId: 'daily-life').location,
      '/flashcards/daily-life',
    );
  });

  test('Settings routes stay typed', () {
    expect(const SettingsRoute().location, '/settings');
    expect(const SettingsLanguageRoute().location, '/settings/language');
  });

  test('Insight, history and streak routes stay typed', () {
    expect(const InsightRoute().location, '/insights');
    expect(const HistoryRoute().location, '/history');
    expect(const StreakRoute().location, '/streak');
  });

  test('Grammar safe Back and final destinations remain typed and stable', () {
    const topicId = 'verb-agreement';
    expect(const HomeRoute().location, '/');
    expect(const GrammarTopicRoute().location, '/grammar');
    expect(
      const GrammarLessonRoute(topicId: topicId).location,
      '/grammar/verb-agreement',
    );
    expect(
      const GrammarLessonRoute(topicId: 'missing').location,
      '/grammar/missing',
    );
    expect(
      const GrammarExerciseRoute(
        topicId: topicId,
        lessonId: 'missing',
      ).location,
      '/grammar/verb-agreement/missing',
    );
    expect(
      const GrammarExerciseRoute(
        topicId: 'verb-tenses',
        lessonId: 'third-person-present',
      ).location,
      '/grammar/verb-tenses/third-person-present',
    );
  });
}
