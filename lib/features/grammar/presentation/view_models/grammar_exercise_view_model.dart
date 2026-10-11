import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/grammar_content.dart';
import '../../domain/repositories/grammar_repository.dart';
import '../providers/grammar_providers.dart';
import '../state/grammar_exercise_state.dart';

final class GrammarExerciseViewModel extends Notifier<GrammarExerciseState> {
  GrammarExerciseViewModel(this._args);

  late GrammarRepository _repository;
  late Duration _minimumDwell;
  final GrammarWorkflowArgs _args;
  var _nextRequestId = 0;

  @override
  GrammarExerciseState build() {
    _repository = ref.watch(grammarRepositoryProvider);
    _minimumDwell = ref.watch(grammarMinimumDwellProvider);
    return _initialize();
  }

  GrammarExerciseState _initialize() {
    final topicResult = _repository.loadTopicById(_args.topicId);
    final lessonResult = _repository.loadLessonById(_args.lessonId);
    if (topicResult is Failure || lessonResult is Failure) {
      return const GrammarInitializationFailure();
    }
    final topic = (topicResult as Success).value as GrammarTopic?;
    final lesson = (lessonResult as Success).value as GrammarLesson?;
    if (topic == null ||
        lesson == null ||
        lesson.topicId != topic.id ||
        lesson.exercises.isEmpty) {
      return const GrammarUnavailable(reason: 'invalidIdentity');
    }
    for (final exercise in lesson.exercises) {
      final exerciseResult = _repository.loadExerciseById(
        lesson.id,
        exercise.id,
      );
      if (exerciseResult is Failure) {
        return const GrammarInitializationFailure();
      }
      if ((exerciseResult as Success).value == null) {
        return const GrammarUnavailable(reason: 'invalidExercise');
      }
    }
    return GrammarAnswering(lesson: lesson, exerciseIndex: 0);
  }

  void retryInitialization() {
    if (state is GrammarInitializationFailure) state = _initialize();
  }

  void answerChanged(String answer) {
    final current = state;
    if (current case GrammarAnswering()) {
      state = GrammarAnswering(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: answer,
        lastVerdict: current.lastVerdict,
      );
    }
  }

  Future<void> submit() async {
    final current = state;
    if (current is! GrammarAnswering || !current.canSubmit) return;
    await _grade(
      lesson: current.lesson,
      exerciseIndex: current.exerciseIndex,
      answer: current.answer,
    );
  }

  Future<void> retry() async {
    final current = state;
    if (current is! GrammarFailure) return;
    await _grade(
      lesson: current.lesson,
      exerciseIndex: current.exerciseIndex,
      answer: current.answer,
    );
  }

  Future<void> _grade({
    required GrammarLesson lesson,
    required int exerciseIndex,
    required String answer,
  }) async {
    final exercise = lesson.exercises[exerciseIndex];
    final exerciseResult = _repository.loadExerciseById(lesson.id, exercise.id);
    if (exerciseResult is Failure) {
      state = const GrammarInitializationFailure();
      return;
    }
    if ((exerciseResult as Success).value == null) {
      state = const GrammarUnavailable(reason: 'invalidExercise');
      return;
    }
    final requestId = ++_nextRequestId;
    state = GrammarSubmitting(
      lesson: lesson,
      exerciseIndex: exerciseIndex,
      answer: answer,
      requestId: requestId,
    );
    try {
      final results = await Future.wait([
        _repository.grade(exercise: exercise, response: answer),
        Future<void>.delayed(_minimumDwell),
      ]);
      if (!ref.mounted) return;
      final current = state;
      if (current is! GrammarSubmitting || current.requestId != requestId) {
        return;
      }
      final verdict = results.first as GrammarVerdict;
      state = verdict.kind == GrammarVerdictKind.correct
          ? GrammarFeedbackCorrect(
              lesson: lesson,
              exerciseIndex: exerciseIndex,
              answer: answer,
              verdict: verdict,
            )
          : GrammarFeedbackIncorrect(
              lesson: lesson,
              exerciseIndex: exerciseIndex,
              answer: answer,
              verdict: verdict,
            );
    } on Object {
      if (!ref.mounted) return;
      final current = state;
      if (current is GrammarSubmitting && current.requestId == requestId) {
        state = GrammarFailure(
          lesson: lesson,
          exerciseIndex: exerciseIndex,
          answer: answer,
        );
      }
    }
  }

  void cancel() {
    final current = state;
    if (current case GrammarSubmitting() || GrammarFailure()) {
      _nextRequestId++;
      final active = current as GrammarActiveState;
      state = GrammarAnswering(
        lesson: active.lesson,
        exerciseIndex: active.exerciseIndex,
        answer: active.answer,
      );
    }
  }

  void fix() {
    final current = state;
    if (current is GrammarFeedbackIncorrect) {
      state = GrammarAnswering(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: current.answer,
      );
    }
  }

  void minimize() {
    final current = state;
    if (current case GrammarFeedback()) {
      state = GrammarFeedbackMinimized(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: current.answer,
        verdict: current.verdict,
      );
    }
  }

  void dismiss() {
    final current = state;
    if (current case GrammarFeedback()) {
      state = GrammarAnswering(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: current.answer,
        lastVerdict: current.verdict,
      );
    }
  }

  void reopenFeedback() {
    final current = state;
    final active = switch (current) {
      GrammarFeedbackMinimized() => current,
      GrammarAnswering(lastVerdict: final verdict?) => GrammarFeedbackMinimized(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: current.answer,
        verdict: verdict,
      ),
      _ => null,
    };
    if (active == null) return;
    state = active.verdict.kind == GrammarVerdictKind.correct
        ? GrammarFeedbackCorrect(
            lesson: active.lesson,
            exerciseIndex: active.exerciseIndex,
            answer: active.answer,
            verdict: active.verdict,
          )
        : GrammarFeedbackIncorrect(
            lesson: active.lesson,
            exerciseIndex: active.exerciseIndex,
            answer: active.answer,
            verdict: active.verdict,
          );
  }

  void next() {
    final current = state;
    if (current is! GrammarFeedback) return;
    if (current.isFinal) {
      state = GrammarFinished(topicId: _args.topicId, lessonId: _args.lessonId);
      return;
    }
    state = GrammarAnswering(
      lesson: current.lesson,
      exerciseIndex: current.exerciseIndex + 1,
    );
  }
}
