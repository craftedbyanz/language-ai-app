import '../../domain/entities/writing_content.dart';

sealed class WritingExerciseState {
  const WritingExerciseState({
    required this.lesson,
    required this.exerciseIndex,
  });

  final WritingLesson lesson;
  final int exerciseIndex;
  WritingExercise get exercise => lesson.exercises[exerciseIndex];
  int get step => exerciseIndex + 1;
  int get stepCount => lesson.exercises.length;
}

final class WritingAnswering extends WritingExerciseState {
  const WritingAnswering({
    required super.lesson,
    required super.exerciseIndex,
    this.answer = '',
  });
  final String answer;
  bool get canSubmit => answer.trim().isNotEmpty;
}

final class WritingSubmitting extends WritingExerciseState {
  const WritingSubmitting({
    required super.lesson,
    required super.exerciseIndex,
    required this.answer,
  });
  final String answer;
}

sealed class WritingFeedback extends WritingExerciseState {
  const WritingFeedback({
    required super.lesson,
    required super.exerciseIndex,
    required this.answer,
    required this.grade,
  });
  final String answer;
  final WritingGrade grade;
}

final class WritingFeedbackCorrect extends WritingFeedback {
  const WritingFeedbackCorrect({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
    required super.grade,
  });
}

final class WritingFeedbackIncorrect extends WritingFeedback {
  const WritingFeedbackIncorrect({
    required super.lesson,
    required super.exerciseIndex,
    required super.answer,
    required super.grade,
  });
}

final class WritingFinished extends WritingExerciseState {
  const WritingFinished({
    required super.lesson,
    required super.exerciseIndex,
    required this.corrections,
  });

  final int corrections;
}
