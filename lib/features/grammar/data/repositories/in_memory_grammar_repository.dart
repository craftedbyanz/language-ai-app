import '../../domain/entities/grammar_content.dart';
import '../../domain/repositories/grammar_repository.dart';

/// Deterministic development adapter. Production grading remains backend-owned.
final class InMemoryGrammarRepository implements GrammarRepository {
  const InMemoryGrammarRepository();

  static final List<GrammarTopic> _topics = List.unmodifiable([
    GrammarTopic(
      id: 'verb-agreement',
      categoryId: 'foundations',
      title: 'Verb agreement',
      lessonCount: 1,
    ),
    GrammarTopic(
      id: 'verb-tenses',
      categoryId: 'verbs',
      title: 'Verb tenses',
      lessonCount: 1,
    ),
  ]);

  static final List<GrammarLesson> _lessons = List.unmodifiable([
    GrammarLesson(
      id: 'third-person-present',
      topicId: 'verb-agreement',
      level: 'A1',
      title: 'Third-person present',
      description: 'Correct common agreement mistakes in everyday sentences.',
      exercises: [
        GrammarSentenceExercise(
          id: 'agreement-1',
          incorrectSentence: 'She work at the library every day.',
          acceptedAnswers: [
            'She works at the library every day.',
            'She works at the library each day.',
          ],
          hints: ['Look at the subject.', 'Check the present-tense verb.'],
          explanation: 'Use works with the third-person singular subject she.',
          tips: ['Add -s to most present-tense verbs after he, she, or it.'],
        ),
        GrammarSentenceExercise(
          id: 'agreement-2',
          incorrectSentence: 'My brother play football on Sundays.',
          acceptedAnswers: ['My brother plays football on Sundays.'],
          hints: ['My brother is singular.', 'Check the verb ending.'],
          explanation: 'A singular third-person subject takes plays.',
          tips: ['Use the base verb with I, you, we, and they.'],
        ),
      ],
    ),
    GrammarLesson(
      id: 'simple-past',
      topicId: 'verb-tenses',
      level: 'A2',
      title: 'Simple past',
      description: 'Repair past-tense sentences with clear time markers.',
      exercises: [
        GrammarSentenceExercise(
          id: 'past-1',
          incorrectSentence: 'Yesterday I walk to the market.',
          acceptedAnswers: ['Yesterday I walked to the market.'],
          hints: ['Yesterday signals the past.'],
          explanation: 'Use walked for a completed past action.',
          tips: ['Regular past-tense verbs commonly end in -ed.'],
        ),
        GrammarSentenceExercise(
          id: 'past-2',
          incorrectSentence: 'They goes home early last night.',
          acceptedAnswers: ['They went home early last night.'],
          hints: ['Go is irregular in the past.'],
          explanation: 'The past form of go is went.',
          tips: ['Learn common irregular past-tense forms as authored pairs.'],
        ),
      ],
    ),
  ]);

  @override
  List<String> get categoryIds => const ['all', 'foundations', 'verbs'];

  @override
  List<GrammarTopic> get topics => _topics;

  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      List.unmodifiable(_lessons.where((lesson) => lesson.topicId == topicId));

  @override
  GrammarTopic? topicById(String topicId) =>
      _firstOrNull(_topics.where((topic) => topic.id == topicId));

  @override
  GrammarLesson? lessonById(String lessonId) =>
      _firstOrNull(_lessons.where((lesson) => lesson.id == lessonId));

  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) {
    final lesson = lessonById(lessonId);
    if (lesson == null) return null;
    return _firstOrNull(
      lesson.exercises.where((exercise) => exercise.id == exerciseId),
    );
  }

  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) async {
    final correct = exercise.acceptedAnswers.any(
      (answer) => _normalize(answer) == _normalize(response),
    );
    return GrammarVerdict(
      kind: correct ? GrammarVerdictKind.correct : GrammarVerdictKind.incorrect,
      originalResponse: response,
      correctedAnswer: exercise.acceptedAnswers.first,
      explanation: exercise.explanation,
      tips: exercise.tips,
    );
  }

  String _normalize(String value) =>
      value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  T? _firstOrNull<T>(Iterable<T> values) {
    final iterator = values.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}
