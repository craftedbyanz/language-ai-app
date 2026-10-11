import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/app/router/app_routes.dart';

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
