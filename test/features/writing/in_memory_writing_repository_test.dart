import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/features/writing/data/repositories/in_memory_writing_repository.dart';

void main() {
  const repository = InMemoryWritingRepository(gradingDelay: Duration.zero);
  final exercise = repository.lessonById('morning-routine').exercises.first;

  test('predefined answer grades correct after normalization', () async {
    final grade = await repository.grade(
      exercise: exercise,
      answer: '  I PRACTICE English every morning.  ',
    );
    expect(grade.isCorrect, isTrue);
    expect(grade.correctedAnswer, exercise.expectedAnswer);
  });

  test(
    'any other non-empty answer deterministically grades incorrect',
    () async {
      final grade = await repository.grade(
        exercise: exercise,
        answer: 'I study sometimes.',
      );
      expect(grade.isCorrect, isFalse);
      expect(grade.improvements, isNotEmpty);
    },
  );
}
