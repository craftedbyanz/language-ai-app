import '../../domain/entities/grammar_content.dart';

sealed class GrammarExerciseState {
  const GrammarExerciseState();
}

sealed class GrammarActiveState extends GrammarExerciseState {
  const GrammarActiveState({
    required this.lesson,
    required this.exerciseIndex,
    required this.answer,
  });
  final GrammarLesson lesson;
  final int exerciseIndex;
  final String answer;
  GrammarSentenceExercise get exercise => lesson.exercises[exerciseIndex];
  int get step => exerciseIndex + 1;
  int get stepCount => lesson.exercises.length;
  bool get isFinal => step == stepCount;
}

final class GrammarAnswering extends GrammarActiveState {
  const GrammarAnswering({
    required super.lesson,
    required super.exerciseIndex,
    super.answer = '',
    this.lastVerdict,
  });
  final GrammarVerdict? lastVerdict;
  bool get canSubmit => answer.trim().isNotEmpty;
}

final class GrammarSubmitting extends GrammarActiveState {
  const GrammarSubmitting({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
    required this.requestId,
  });
  final int requestId;
}

sealed class GrammarFeedback extends GrammarActiveState {
  const GrammarFeedback({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
    required this.verdict,
  });
  final GrammarVerdict verdict;
}

final class GrammarFeedbackCorrect extends GrammarFeedback {
  const GrammarFeedbackCorrect({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
    required super.verdict,
  });
}

final class GrammarFeedbackIncorrect extends GrammarFeedback {
  const GrammarFeedbackIncorrect({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
    required super.verdict,
  });
}

final class GrammarFeedbackMinimized extends GrammarActiveState {
  const GrammarFeedbackMinimized({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
    required this.verdict,
  });
  final GrammarVerdict verdict;
}

final class GrammarFailure extends GrammarActiveState {
  const GrammarFailure({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
  });
}

final class GrammarFinished extends GrammarExerciseState {
  const GrammarFinished({required this.topicId, required this.lessonId});
  final String topicId;
  final String lessonId;
}

final class GrammarUnavailable extends GrammarExerciseState {
  const GrammarUnavailable({required this.reason});
  final String reason;
}

/// An unexpected catalog/repository failure while creating the workflow.
/// This is distinct from a valid lookup that proves an identity is absent.
final class GrammarInitializationFailure extends GrammarExerciseState {
  const GrammarInitializationFailure();
}
