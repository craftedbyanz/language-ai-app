import '../../../../core/error/app_failure.dart';
import '../../../../core/result/result.dart';
import '../entities/grammar_content.dart';

/// Client development boundary. Production grading is backend-owned and a
/// production adapter must consume the backend's resolved semantic verdict.
abstract interface class GrammarRepository {
  List<String> get categoryIds;
  List<GrammarTopic> get topics;
  List<GrammarLesson> lessonsForTopic(String topicId);
  GrammarTopic? topicById(String topicId);
  GrammarLesson? lessonById(String lessonId);
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId);
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  });
}

/// Typed catalog access at the feature repository boundary.
///
/// Missing identities remain successful `null` results. Only unexpected
/// repository failures are converted to [UnknownFailure], keeping raw adapter
/// exceptions out of presentation code.
extension GrammarRepositoryCatalogResults on GrammarRepository {
  Result<List<String>> loadCategoryIds() => _capture(() => categoryIds);

  Result<List<GrammarTopic>> loadTopics() => _capture(() => topics);

  Result<List<GrammarLesson>> loadLessonsForTopic(String topicId) =>
      _capture(() => lessonsForTopic(topicId));

  Result<GrammarTopic?> loadTopicById(String topicId) =>
      _capture(() => topicById(topicId));

  Result<GrammarLesson?> loadLessonById(String lessonId) =>
      _capture(() => lessonById(lessonId));

  Result<GrammarSentenceExercise?> loadExerciseById(
    String lessonId,
    String exerciseId,
  ) => _capture(() => exerciseById(lessonId, exerciseId));
}

Result<T> _capture<T>(T Function() operation) {
  try {
    return Success(operation());
  } on Object {
    return const Failure(UnknownFailure());
  }
}
