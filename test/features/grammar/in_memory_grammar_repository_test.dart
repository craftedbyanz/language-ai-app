import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/features/grammar/data/repositories/in_memory_grammar_repository.dart';
import 'package:hifive/features/grammar/domain/entities/grammar_content.dart';

void main() {
  const repository = InMemoryGrammarRepository();

  test(
    'catalog is ordered, related, and unknown identities do not fallback',
    () {
      expect(repository.categoryIds, ['all', 'foundations', 'verbs']);
      expect(repository.topics.map((topic) => topic.id), [
        'verb-agreement',
        'verb-tenses',
      ]);
      for (final topic in repository.topics) {
        expect(topic.description, isNotEmpty);
        expect(topic.level, isNotEmpty);
        final lessons = repository.lessonsForTopic(topic.id);
        expect(lessons, hasLength(topic.lessonCount));
        expect(
          lessons,
          everyElement(
            predicate<GrammarLesson>((lesson) => lesson.topicId == topic.id),
          ),
        );
        expect(
          lessons,
          everyElement(
            predicate<GrammarLesson>((lesson) => lesson.exercises.length >= 2),
          ),
        );
      }
      expect(repository.lessonsForTopic('missing'), isEmpty);
      expect(repository.topicById('missing'), isNull);
      expect(repository.lessonById('missing'), isNull);
      expect(repository.exerciseById('missing', 'missing'), isNull);
    },
  );

  test(
    'grading normalizes only trim, case, and collapsed whitespace',
    () async {
      final exercise = repository
          .lessonById('third-person-present')!
          .exercises
          .first;
      for (final response in [
        'She works at the library every day.',
        '  SHE   WORKS at the library every day.  ',
        'She works at the library each day.',
      ]) {
        expect(
          (await repository.grade(exercise: exercise, response: response)).kind,
          GrammarVerdictKind.correct,
        );
      }
      for (final response in [
        'She works at the library every day',
        'Every day she works at the library.',
        'She wo\u0072\u006bs at the libra\u0072y every da\u0079.\u0301',
      ]) {
        expect(
          (await repository.grade(exercise: exercise, response: response)).kind,
          GrammarVerdictKind.incorrect,
        );
      }
    },
  );

  test(
    'incorrect verdict preserves exact response and authored feedback',
    () async {
      final exercise = repository
          .lessonById('third-person-present')!
          .exercises
          .first;
      const response = '  She work here.  ';
      final verdict = await repository.grade(
        exercise: exercise,
        response: response,
      );
      expect(verdict.kind, GrammarVerdictKind.incorrect);
      expect(verdict.originalResponse, response);
      expect(verdict.correctedAnswer, exercise.acceptedAnswers.first);
      expect(verdict.explanation, exercise.explanation);
      expect(verdict.tips, exercise.tips);
    },
  );

  test('100 executions produce the identical verdict', () async {
    final exercise = repository.lessonById('simple-past')!.exercises.first;
    final verdicts = <GrammarVerdict>[];
    for (var index = 0; index < 100; index++) {
      verdicts.add(
        await repository.grade(
          exercise: exercise,
          response: 'Yesterday I walked to the market.',
        ),
      );
    }
    expect(
      verdicts,
      everyElement(
        predicate<GrammarVerdict>(
          (verdict) =>
              verdict.kind == GrammarVerdictKind.correct &&
              verdict.correctedAnswer == exercise.acceptedAnswers.first,
        ),
      ),
    );
  });

  test('domain collections are immutable and reject invalid content', () {
    final exercise = GrammarSentenceExercise(
      id: 'immutable',
      incorrectSentence: 'They walks.',
      acceptedAnswers: const ['They walk.'],
      hints: const ['Check the subject.'],
      explanation: 'Use the plural verb form.',
      tips: const ['Match subject and verb.'],
    );
    final lesson = GrammarLesson(
      id: 'immutable-lesson',
      topicId: 'immutable-topic',
      level: 'A1',
      title: 'Immutable lesson',
      description: 'Exercises cannot be mutated externally.',
      exercises: [exercise],
    );
    final verdict = GrammarVerdict(
      kind: GrammarVerdictKind.incorrect,
      originalResponse: 'They walks.',
      correctedAnswer: 'They walk.',
      explanation: 'Use the plural verb form.',
      tips: const ['Match subject and verb.'],
    );

    expect(() => exercise.acceptedAnswers.add('Other'), throwsUnsupportedError);
    expect(() => exercise.hints.clear(), throwsUnsupportedError);
    expect(() => exercise.tips.clear(), throwsUnsupportedError);
    expect(() => lesson.exercises.clear(), throwsUnsupportedError);
    expect(() => verdict.tips.clear(), throwsUnsupportedError);
    expect(
      () => GrammarLesson(
        id: 'empty',
        topicId: 'topic',
        level: 'A1',
        title: 'Empty',
        description: 'Invalid',
        exercises: const [],
      ),
      throwsArgumentError,
    );
    expect(
      () => GrammarSentenceExercise(
        id: 'empty-answers',
        incorrectSentence: 'Bad sentence.',
        acceptedAnswers: const [],
        hints: const [],
        explanation: 'Explanation',
        tips: const [],
      ),
      throwsArgumentError,
    );
    for (final invalid in [
      () => GrammarSentenceExercise(
        id: 'blank-answer',
        incorrectSentence: 'Bad sentence.',
        acceptedAnswers: const ['   '],
        hints: const [],
        explanation: 'Explanation',
        tips: const [],
      ),
      () => GrammarSentenceExercise(
        id: 'blank-hint',
        incorrectSentence: 'Bad sentence.',
        acceptedAnswers: const ['Good sentence.'],
        hints: const [''],
        explanation: 'Explanation',
        tips: const [],
      ),
      () => GrammarSentenceExercise(
        id: 'blank-tip',
        incorrectSentence: 'Bad sentence.',
        acceptedAnswers: const ['Good sentence.'],
        hints: const [],
        explanation: 'Explanation',
        tips: const ['\n'],
      ),
    ]) {
      expect(invalid, throwsArgumentError);
    }
  });

  test('repository catalog is deeply immutable across callers', () async {
    final categories = repository.categoryIds;
    final topics = repository.topics;
    final lessons = repository.lessonsForTopic('verb-agreement');
    final exercise = lessons.first.exercises.first;
    final verdict = await repository.grade(exercise: exercise, response: 'x');

    expect(() => categories.add('mutated'), throwsUnsupportedError);
    expect(() => topics.clear(), throwsUnsupportedError);
    expect(() => lessons[0] = lessons.first, throwsUnsupportedError);
    expect(() => lessons.first.exercises.clear(), throwsUnsupportedError);
    expect(() => exercise.acceptedAnswers.clear(), throwsUnsupportedError);
    expect(() => exercise.hints.add('mutated'), throwsUnsupportedError);
    expect(() => exercise.tips.clear(), throwsUnsupportedError);
    expect(() => verdict.tips.add('mutated'), throwsUnsupportedError);

    final later = repository.lessonById('third-person-present')!;
    expect(later.exercises, hasLength(20));
    expect(
      later.exercises.map((exercise) => exercise.id).toSet(),
      hasLength(20),
    );
    expect(
      later.exercises.first.acceptedAnswers.first,
      'She works at the library every day.',
    );
    expect(
      (await repository.grade(
        exercise: later.exercises.first,
        response: 'She works at the library every day.',
      )).kind,
      GrammarVerdictKind.correct,
    );
  });
}
