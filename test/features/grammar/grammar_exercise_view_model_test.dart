import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/features/grammar/data/repositories/in_memory_grammar_repository.dart';
import 'package:lingua/features/grammar/domain/entities/grammar_content.dart';
import 'package:lingua/features/grammar/domain/repositories/grammar_repository.dart';
import 'package:lingua/features/grammar/presentation/providers/grammar_providers.dart';
import 'package:lingua/features/grammar/presentation/state/grammar_exercise_state.dart';

void main() {
  const args = GrammarWorkflowArgs(
    topicId: 'verb-agreement',
    lessonId: 'third-person-present',
  );

  ProviderContainer containerFor({GrammarRepository? repository}) {
    final container = ProviderContainer(
      overrides: [
        grammarRepositoryProvider.overrideWithValue(
          repository ?? const InMemoryGrammarRepository(),
        ),
        grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
      ],
    );
    addTearDown(container.dispose);
    container.listen(grammarExerciseViewModelProvider(args), (_, _) {});
    return container;
  }

  test('blank submit is suppressed and correct answer advances once', () async {
    final container = containerFor();
    final notifier = container.read(
      grammarExerciseViewModelProvider(args).notifier,
    );
    await notifier.submit();
    expect(
      container.read(grammarExerciseViewModelProvider(args)),
      isA<GrammarAnswering>(),
    );
    notifier.answerChanged('She works at the library every day.');
    final pending = notifier.submit();
    expect(
      container.read(grammarExerciseViewModelProvider(args)),
      isA<GrammarSubmitting>(),
    );
    await pending;
    expect(
      container.read(grammarExerciseViewModelProvider(args)),
      isA<GrammarFeedbackCorrect>(),
    );
    notifier.next();
    expect(
      (container.read(
        grammarExerciseViewModelProvider(args),
      ) as GrammarAnswering).step,
      2,
    );
    notifier.next();
    expect(
      (container.read(
        grammarExerciseViewModelProvider(args),
      ) as GrammarAnswering).step,
      2,
    );
  });

  test('cancel invalidates stale result and preserves exact answer', () async {
    final repository = _ControlledRepository();
    final container = containerFor(repository: repository);
    final notifier = container.read(
      grammarExerciseViewModelProvider(args).notifier,
    );
    const answer = '  exact answer  ';
    notifier.answerChanged(answer);
    final pending = notifier.submit();
    await notifier.submit();
    expect(repository.calls, 1);
    notifier.cancel();
    repository.completeCorrect();
    await pending;
    final state = container.read(
      grammarExerciseViewModelProvider(args),
    ) as GrammarAnswering;
    expect(state.answer, answer);
    expect(repository.calls, 1);
  });

  test(
    'failure retains state, retries explicitly, and cancel restores answering',
    () async {
      final repository = _ThrowingRepository();
      final container = containerFor(repository: repository);
      final notifier = container.read(
        grammarExerciseViewModelProvider(args).notifier,
      );
      notifier.answerChanged('keep me');
      await notifier.submit();
      final failure = container.read(
        grammarExerciseViewModelProvider(args),
      ) as GrammarFailure;
      expect(failure.answer, 'keep me');
      expect(repository.calls, 1);
      await notifier.retry();
      expect(repository.calls, 2);
      notifier.cancel();
      expect(
        (container.read(
          grammarExerciseViewModelProvider(args),
        ) as GrammarAnswering).answer,
        'keep me',
      );
    },
  );

  test(
    'incorrect fix and minimize/reopen preserve response and verdict',
    () async {
      final container = containerFor();
      final notifier = container.read(
        grammarExerciseViewModelProvider(args).notifier,
      );
      notifier.answerChanged('She work here.');
      await notifier.submit();
      final feedback = container.read(
        grammarExerciseViewModelProvider(args),
      ) as GrammarFeedbackIncorrect;
      notifier.minimize();
      expect(
        container.read(grammarExerciseViewModelProvider(args)),
        isA<GrammarFeedbackMinimized>(),
      );
      notifier.reopenFeedback();
      expect(
        (container.read(
          grammarExerciseViewModelProvider(args),
        ) as GrammarFeedbackIncorrect).verdict,
        same(feedback.verdict),
      );
      notifier.fix();
      expect(
        (container.read(
          grammarExerciseViewModelProvider(args),
        ) as GrammarAnswering).answer,
        'She work here.',
      );
    },
  );

  test('invalid identities produce unavailable without grading', () {
    const invalid = GrammarWorkflowArgs(
      topicId: 'missing',
      lessonId: 'missing',
    );
    final container = containerFor();
    expect(
      container.read(grammarExerciseViewModelProvider(invalid)),
      isA<GrammarUnavailable>(),
    );
  });

  for (final missingExerciseId in ['agreement-1', 'agreement-2']) {
    test(
      'missing authored exercise $missingExerciseId prevents workflow creation',
      () {
        final repository = _MissingExerciseRepository(missingExerciseId);
        final container = containerFor(repository: repository);
        final state = container.read(grammarExerciseViewModelProvider(args));
        expect(state, isA<GrammarUnavailable>());
        expect(state, isNot(isA<GrammarActiveState>()));
        expect(repository.gradeCalls, 0);
      },
    );
  }

  test(
    'exercise catalog failure is typed and Retry performs a fresh lookup',
    () {
      final repository = _ThrowingExerciseLookupRepository();
      final container = containerFor(repository: repository);
      final notifier = container.read(
        grammarExerciseViewModelProvider(args).notifier,
      );
      expect(
        container.read(grammarExerciseViewModelProvider(args)),
        isA<GrammarInitializationFailure>(),
      );
      expect(repository.gradeCalls, 0);
      notifier.retryInitialization();
      final recovered = container.read(grammarExerciseViewModelProvider(args));
      expect(recovered, isA<GrammarAnswering>());
      expect((recovered as GrammarAnswering).exerciseIndex, 0);
      expect(repository.exerciseLookups, greaterThan(1));
      expect(repository.gradeCalls, 0);
    },
  );

  test(
    'invalid current exercise is rejected without grading or progress',
    () async {
      final repository = _InvalidatingExerciseRepository();
      final container = containerFor(repository: repository);
      final notifier = container.read(
        grammarExerciseViewModelProvider(args).notifier,
      );
      notifier.answerChanged('She works at the library every day.');
      await notifier.submit();
      expect(
        container.read(grammarExerciseViewModelProvider(args)),
        isA<GrammarUnavailable>(),
      );
      expect(repository.gradeCalls, 0);
    },
  );

  test(
    'explicit retry uses a new request identity without auto retry',
    () async {
      final repository = _SequencedRepository();
      final container = containerFor(repository: repository);
      final notifier = container.read(
        grammarExerciseViewModelProvider(args).notifier,
      );
      notifier.answerChanged('keep me');
      final firstPending = notifier.submit();
      final firstId = (container.read(
        grammarExerciseViewModelProvider(args),
      ) as GrammarSubmitting).requestId;
      repository.failNext();
      await firstPending;
      expect(repository.calls, 1);
      expect(
        container.read(grammarExerciseViewModelProvider(args)),
        isA<GrammarFailure>(),
      );

      final retryPending = notifier.retry();
      final retryId = (container.read(
        grammarExerciseViewModelProvider(args),
      ) as GrammarSubmitting).requestId;
      expect(retryId, greaterThan(firstId));
      expect(repository.calls, 2);
      repository.failNext();
      await retryPending;
      expect(repository.calls, 2);
    },
  );

  test('final outcome is emitted once and cannot progress again', () async {
    final container = containerFor();
    final notifier = container.read(
      grammarExerciseViewModelProvider(args).notifier,
    );
    final lesson = const InMemoryGrammarRepository().lessonById(
      'third-person-present',
    )!;
    for (final exercise in lesson.exercises) {
      notifier.answerChanged(exercise.acceptedAnswers.first);
      await notifier.submit();
      notifier.next();
    }
    final finished = container.read(grammarExerciseViewModelProvider(args));
    expect(finished, isA<GrammarFinished>());
    notifier.next();
    expect(
      container.read(grammarExerciseViewModelProvider(args)),
      same(finished),
    );
  });

  test('disposed workflow ignores late grading and reopens fresh', () async {
    final repository = _ControlledRepository();
    final container = ProviderContainer(
      overrides: [
        grammarRepositoryProvider.overrideWithValue(repository),
        grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      grammarExerciseViewModelProvider(args),
      (_, _) {},
    );
    final notifier = container.read(
      grammarExerciseViewModelProvider(args).notifier,
    );
    notifier.answerChanged('She works at the library every day.');
    final pending = notifier.submit();
    subscription.close();
    await container.pump();
    repository.completeCorrect();
    await pending;

    final reopened = container.listen(
      grammarExerciseViewModelProvider(args),
      (_, _) {},
    );
    addTearDown(reopened.close);
    final state = container.read(grammarExerciseViewModelProvider(args));
    expect(state, isA<GrammarAnswering>());
    expect((state as GrammarAnswering).exerciseIndex, 0);
    expect(state.answer, isEmpty);
  });

  test('progressed workflow disposes and re-enters at index zero', () async {
    final container = ProviderContainer(
      overrides: [
        grammarRepositoryProvider.overrideWithValue(
          const InMemoryGrammarRepository(),
        ),
        grammarMinimumDwellProvider.overrideWithValue(Duration.zero),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      grammarExerciseViewModelProvider(args),
      (_, _) {},
    );
    final notifier = container.read(
      grammarExerciseViewModelProvider(args).notifier,
    );
    notifier.answerChanged('She works at the library every day.');
    await notifier.submit();
    notifier.next();
    final progressed = container.read(
      grammarExerciseViewModelProvider(args),
    ) as GrammarAnswering;
    expect(progressed.exerciseIndex, 1);

    subscription.close();
    await container.pump();
    final reopened = container.listen(
      grammarExerciseViewModelProvider(args),
      (_, _) {},
    );
    addTearDown(reopened.close);
    final fresh = container.read(
      grammarExerciseViewModelProvider(args),
    ) as GrammarAnswering;
    expect(fresh.exerciseIndex, 0);
    expect(fresh.answer, isEmpty);
    expect(fresh.lastVerdict, isNull);
  });

  test('default minimum dwell keeps Loading visible for 300 ms', () async {
    final container = ProviderContainer(
      overrides: [
        grammarRepositoryProvider.overrideWithValue(
          const InMemoryGrammarRepository(),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(grammarExerciseViewModelProvider(args), (_, _) {});
    final notifier = container.read(
      grammarExerciseViewModelProvider(args).notifier,
    );
    notifier.answerChanged('She works at the library every day.');
    final stopwatch = Stopwatch()..start();
    await notifier.submit();
    stopwatch.stop();
    expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(290));
    expect(
      container.read(grammarExerciseViewModelProvider(args)),
      isA<GrammarFeedbackCorrect>(),
    );
  });

  test('100 fresh workflows progress exactly one step', () async {
    for (var index = 0; index < 100; index++) {
      final container = containerFor();
      final notifier = container.read(
        grammarExerciseViewModelProvider(args).notifier,
      );
      notifier.answerChanged('She works at the library every day.');
      await notifier.submit();
      notifier.next();
      final state = container.read(
        grammarExerciseViewModelProvider(args),
      ) as GrammarAnswering;
      expect(state.exerciseIndex, 1);
      expect(state.answer, isEmpty);
    }
  });
}

class _ControlledRepository implements GrammarRepository {
  final _delegate = const InMemoryGrammarRepository();
  final _completion = Completer<GrammarVerdict>();
  var calls = 0;

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) => _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) =>
      _delegate.exerciseById(lessonId, exerciseId);
  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) {
    calls++;
    return _completion.future;
  }

  void completeCorrect() => _completion.complete(
    GrammarVerdict(
      kind: GrammarVerdictKind.correct,
      originalResponse: '  exact answer  ',
      correctedAnswer: _delegate
          .lessonById('third-person-present')!
          .exercises
          .first
          .acceptedAnswers
          .first,
      explanation: 'Explanation',
      tips: const [],
    ),
  );
}

class _ThrowingRepository extends _ControlledRepository {
  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) async {
    calls++;
    throw StateError('deterministic failure');
  }
}

class _InvalidatingExerciseRepository implements GrammarRepository {
  final _delegate = const InMemoryGrammarRepository();
  var exerciseLookups = 0;
  var gradeCalls = 0;

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) => _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) {
    exerciseLookups++;
    return exerciseLookups == 1
        ? _delegate.exerciseById(lessonId, exerciseId)
        : null;
  }

  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) {
    gradeCalls++;
    return _delegate.grade(exercise: exercise, response: response);
  }
}

class _SequencedRepository implements GrammarRepository {
  final _delegate = const InMemoryGrammarRepository();
  final _pending = <Completer<GrammarVerdict>>[];
  var calls = 0;

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) => _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) =>
      _delegate.exerciseById(lessonId, exerciseId);
  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) {
    calls++;
    final completer = Completer<GrammarVerdict>();
    _pending.add(completer);
    return completer.future;
  }

  void failNext() => _pending.removeAt(0).completeError(StateError('failure'));
}

class _MissingExerciseRepository implements GrammarRepository {
  _MissingExerciseRepository(this.missingExerciseId);

  final String missingExerciseId;
  final _delegate = const InMemoryGrammarRepository();
  var gradeCalls = 0;

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) => _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) =>
      exerciseId == missingExerciseId
      ? null
      : _delegate.exerciseById(lessonId, exerciseId);
  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) {
    gradeCalls++;
    return _delegate.grade(exercise: exercise, response: response);
  }
}

class _ThrowingExerciseLookupRepository implements GrammarRepository {
  final _delegate = const InMemoryGrammarRepository();
  var exerciseLookups = 0;
  var gradeCalls = 0;

  @override
  List<String> get categoryIds => _delegate.categoryIds;
  @override
  List<GrammarTopic> get topics => _delegate.topics;
  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      _delegate.lessonsForTopic(topicId);
  @override
  GrammarTopic? topicById(String topicId) => _delegate.topicById(topicId);
  @override
  GrammarLesson? lessonById(String lessonId) => _delegate.lessonById(lessonId);
  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) {
    exerciseLookups++;
    if (exerciseLookups == 1) throw StateError('catalog unavailable');
    return _delegate.exerciseById(lessonId, exerciseId);
  }

  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) {
    gradeCalls++;
    return _delegate.grade(exercise: exercise, response: response);
  }
}
