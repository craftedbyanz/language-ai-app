import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/tokens/generated/design_tokens.dart';
import '../../data/repositories/in_memory_writing_repository.dart';
import '../../domain/repositories/writing_repository.dart';
import '../state/writing_exercise_state.dart';

final writingRepositoryProvider = Provider<WritingRepository>(
  // DD-10 default: the local grading demo uses the canonical sheet duration.
  (ref) => const InMemoryWritingRepository(gradingDelay: MotionTokens.sheet),
);

final writingExerciseViewModelProvider =
    NotifierProvider<WritingExerciseViewModel, WritingExerciseState>(
      WritingExerciseViewModel.new,
    );

final class WritingExerciseViewModel extends Notifier<WritingExerciseState> {
  late WritingRepository _repository;

  @override
  WritingExerciseState build() {
    _repository = ref.watch(writingRepositoryProvider);
    return WritingAnswering(
      lesson: _repository.lessonById('morning-routine'),
      exerciseIndex: 0,
    );
  }

  void selectLesson(String lessonId) {
    state = WritingAnswering(
      lesson: _repository.lessonById(lessonId),
      exerciseIndex: 0,
    );
  }

  void answerChanged(String answer) {
    final current = state;
    if (current case WritingAnswering()) {
      state = WritingAnswering(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: answer,
      );
    }
  }

  Future<void> submit() async {
    final current = state;
    if (current is! WritingAnswering || !current.canSubmit) return;
    state = WritingSubmitting(
      lesson: current.lesson,
      exerciseIndex: current.exerciseIndex,
      answer: current.answer,
    );
    final grade = await _repository.grade(
      exercise: current.exercise,
      answer: current.answer,
    );
    final feedback = grade.isCorrect
        ? WritingFeedbackCorrect(
            lesson: current.lesson,
            exerciseIndex: current.exerciseIndex,
            answer: current.answer,
            grade: grade,
          )
        : WritingFeedbackIncorrect(
            lesson: current.lesson,
            exerciseIndex: current.exerciseIndex,
            answer: current.answer,
            grade: grade,
          );
    state = feedback;
  }

  void edit() {
    final current = state;
    if (current case WritingFeedback()) {
      state = WritingAnswering(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: current.answer,
      );
    }
  }

  void cancelSubmission() {
    final current = state;
    if (current case WritingSubmitting()) {
      state = WritingAnswering(
        lesson: current.lesson,
        exerciseIndex: current.exerciseIndex,
        answer: current.answer,
      );
    }
  }

  void next() {
    final current = state;
    if (current is! WritingFeedback) return;
    final nextIndex = current.exerciseIndex + 1;
    state = WritingAnswering(
      lesson: current.lesson,
      exerciseIndex: nextIndex < current.lesson.exercises.length
          ? nextIndex
          : 0,
    );
  }
}
