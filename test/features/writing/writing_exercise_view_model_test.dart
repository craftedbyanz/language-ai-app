import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/features/writing/data/repositories/in_memory_writing_repository.dart';
import 'package:lingua/features/writing/presentation/state/writing_exercise_state.dart';
import 'package:lingua/features/writing/presentation/view_models/writing_exercise_view_model.dart';

void main() {
  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        writingRepositoryProvider.overrideWithValue(
          const InMemoryWritingRepository(gradingDelay: Duration.zero),
        ),
      ],
    );
    addTearDown(container.dispose);
    container.listen(writingExerciseViewModelProvider, (_, _) {});
    return container;
  }

  test('initial state is an empty answering state with submit unavailable', () {
    final state = createContainer().read(writingExerciseViewModelProvider);
    expect(state, isA<WritingAnswering>());
    expect((state as WritingAnswering).canSubmit, isFalse);
    expect(state.step, 1);
  });

  test(
    'answer enables submit and submit transitions through loading to correct',
    () async {
      final container = createContainer();
      final notifier = container.read(
        writingExerciseViewModelProvider.notifier,
      );
      notifier.answerChanged('I practice English every morning.');
      expect(
        (container.read(
          writingExerciseViewModelProvider,
        ) as WritingAnswering).canSubmit,
        isTrue,
      );
      final pending = notifier.submit();
      expect(
        container.read(writingExerciseViewModelProvider),
        isA<WritingSubmitting>(),
      );
      await pending;
      expect(
        container.read(writingExerciseViewModelProvider),
        isA<WritingFeedbackCorrect>(),
      );
    },
  );

  test('incorrect feedback and next form one valid state at a time', () async {
    final container = createContainer();
    final notifier = container.read(writingExerciseViewModelProvider.notifier);
    notifier.answerChanged('Wrong answer');
    await notifier.submit();
    final feedback = container.read(writingExerciseViewModelProvider);
    expect(feedback, isA<WritingFeedbackIncorrect>());
    expect(feedback, isNot(isA<WritingAnswering>()));
    notifier.next();
    final next =
        container.read(writingExerciseViewModelProvider) as WritingAnswering;
    expect(next.step, 2);
    expect(next.answer, isEmpty);
    expect(next.exercise.sourceText, contains('Sau đó'));
  });
}
